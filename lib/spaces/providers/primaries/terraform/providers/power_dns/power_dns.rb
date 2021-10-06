module Providers
  module Terraform
    module PowerDns
      class PowerDns < ::Providers::PowerDns::PowerDns

        def provider_artifact
          %(
            provider "powerdns" {
              api_key    = "#{configuration.api_key}"
              server_url = "#{protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
            resource "powerdns_zone" "#{arena.identifier}-zone" {
              name        = "#{arena.identifier}.#{universe.host}."
              kind        = "native"
              nameservers = [#{dns_address}]
            }
          )
        end

        def required_stanza
          %(
            powerdns = {
              version = "#{configuration.version}"
              source  = "#{configuration.source}"
            }
          )
        end

        def stanzas_for(resolution)
          %(
            resource "powerdns_record" "#{resolution.blueprint_identifier}" {
              zone    = "#{universe.host}."
              name    = "#{resolution.blueprint_identifier}.#{universe.host}."
              type    = "AAAA"
              ttl     = #{configuration.ttl}
              records = [#{container_address_for(resolution)}]
            }
          )
        end

      end
    end
  end
end
