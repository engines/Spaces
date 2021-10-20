module Artifacts
  module Terraform
    class DnsStanza < ::Artifacts::Stanza

      def snippets
        %(
          resource "#{dns_qualifier}_record" "#{blueprint_identifier}" {
            zone    = "#{universe.host}."
            name    = "#{blueprint_identifier}.#{universe.host}."
            type    = "AAAA"
            ttl     = #{dns.input.ttl}
            records = [#{container_address_snippet}]
          }
        )
      end

      def container_address_snippet
        "#{container_type}.#{blueprint_identifier}.ipv6_address"
      end

    end
  end
end
