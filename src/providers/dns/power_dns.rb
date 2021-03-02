module Providers
  class PowerDns < ::Providers::Provider

    def arena_stanzas
      %(
        provider "powerdns" {
          api_key    = "#{configuration.api_key}"
          server_url = "#{protocol}://#{arena.identifier}.#{universe.host}:#{port}/#{endpoint}"
        }

        resource "powerdns_zone" "#{arena.identifier}-zone" {
          name        = "#{arena.identifier}"
          kind        = "native"
          nameservers = []
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

    def blueprint_stanzas_for(resolution)
      %(
        resource "powerdns_record" "#{resolution.blueprint_identifier}" {
          zone    = "#{universe.host}"
          name    = "#{resolution.blueprint_identifier}.#{universe.host}"
          type    = "AAAA"
          ttl     = #{configuration.ttl}
          records = [${var.ip_address}]
        }
      )
    end

    def protocol; configuration.struct.protocol || 'protocol' ;end
    def port; configuration.struct.port || 8081 ;end
    def endpoint; configuration.struct.endpoint ;end

  end
end
