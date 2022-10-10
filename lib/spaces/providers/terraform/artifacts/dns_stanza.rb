module Artifacts
  module Terraform
    class DnsStanza < ::Artifacts::Stanza

      def snippets
        # TODO: refactor the long method chain for ttl
        %(
          resource "#{dns_qualifier}_record" "#{resource_identifier}" {
            zone    = "#{universe.host}."
            name    = "#{resource_identifier}.#{universe.host}."
            type    = "AAAA"
            ttl     = #{arena.role_providers.dns.resolution.configuration.ttl}
            records = [#{container_address_snippet}]
          }
        ) unless redundant
      end

      def redundant = dns_qualifier == resource_identifier

      def container_address_snippet =
        "#{container_type}.#{resource_identifier}.ipv6_address"

    end
  end
end
