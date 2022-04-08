module Artifacts
  module Terraform
    class DnsStanza < ::Artifacts::Stanza

      def snippets
        # TODO: refactor the long method chain for ttl
        %(
          resource "#{dns_qualifier}_record" "#{blueprint_identifier}" {
            zone    = "#{universe.host}."
            name    = "#{blueprint_identifier}.#{universe.host}."
            type    = "AAAA"
            ttl     = #{arena.role_providers.dns.resolution.configuration.ttl}
            records = [#{container_address_snippet}]
          }
        ) unless redundant
      end

      def redundant; dns_qualifier == blueprint_identifier ;end

      def container_address_snippet
        "#{container_type}.#{blueprint_identifier}.ipv6_address"
      end

    end
  end
end
