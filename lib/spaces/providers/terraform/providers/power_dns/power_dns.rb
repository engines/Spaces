# TODO: FIX -- Terraform-specific!----------------------------------------------

module Providers
  module Terraform
    module PowerDns
      class PowerDns < ::ProviderAspects::Provider

        def dns_address; "#{container_type}.#{blueprint_identifier}.ipv4_address" ;end

        def container_address_for(resolution); "#{container_type}.#{resolution.blueprint_identifier}.ipv6_address" ;end

        def protocol; configuration.struct.protocol || 'http' ;end
        def port; configuration.struct.port || 8081 ;end
        def endpoint; configuration.struct.endpoint ;end


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
