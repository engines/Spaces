module Artifacts
  module Terraform
    class DnsStanza < ::Artifacts::Stanza

      def snippets
        # TODO: refactor the long method chain for ttl
        %(
          resource "#{dns_qualifier}_record" "#{application_identifier}" {
            zone    = "#{universe.host}."
            name    = "#{application_identifier}.#{universe.host}."
            type    = "AAAA"
            ttl     = #{arena.role_providers.dns.resolution.configuration.ttl}
            records = [#{container_address_snippet}]
          }
        ) unless redundant
      end

      def redundant; dns_qualifier == application_identifier ;end

      def container_address_snippet
        "#{container_type}.#{application_identifier}.ipv6_address"
      end

    end
  end
end
