module Artifacts
  module Terraform
    class DnsStanza < ::Artifacts::Stanza

      def snippets
        # TODO: FIX --- remove hard-coding for PowerDNS
        # %(
        #   resource "#{resource_qualifier}_record" "#{blueprint_identifier}" {
        #     zone    = "#{universe.host}."
        #     name    = "#{blueprint_identifier}.#{universe.host}."
        #     type    = "AAAA"
        #     ttl     = #{dns.input.ttl}
        #     records = [#{container_address_for(resolution)}]
        #   }
        # )
        %(
          resource "#{resource_qualifier}_record" "#{blueprint_identifier}" {
            zone    = "#{universe.host}."
            name    = "#{blueprint_identifier}.#{universe.host}."
            type    = "AAAA"
            ttl     = #{dns.input.ttl}
          }
        )
      end

      def resource_qualifier #TODO: REFACTOR!
        artifact.adapter.provisioning_provider.dns_qualifier.camelize.downcase
      end

    end
  end
end
