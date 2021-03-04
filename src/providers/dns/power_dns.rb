module Providers
  class PowerDns < ::Providers::Provider

    def arena_stanzas
      %(
        provider "powerdns" {
          api_key    = "#{configuration.api_key}"
          
          server_url = "#{protocol}://127.0.0.1:#{port}/#{endpoint}"
#127.0.0.1 is a temp kludge  pdns.#{arena.identifier}.#{universe.host} is closer to the final thoudh pdns should be inferred 
#or perhaps just use lxd_container.pdns.ip_address once again pdns should be inferred
        }

        resource "powerdns_zone" "#{arena.identifier}-zone" {
          name        = "#{arena.identifier}.#{universe.host}."
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
          name    = "#{resolution.blueprint_identifier}.#{universe.host}."
          type    = "AAAA"
          ttl     = #{configuration.ttl}
          records = [#{records_for(resolution)}]
        }
      )
    end

    def records_for(resolution)
      resolution.containers.all.map do |c|
        "#{c.resource_type}.#{resolution.blueprint_identifier}.ip_address"
      end.join(', ')
    end

    def protocol; configuration.struct.protocol || 'protocol' ;end
    def port; configuration.struct.port || 8081 ;end
    def endpoint; configuration.struct.endpoint ;end

  end
end
