

module Providers
  class PowerDns < ::Providers::Provider
    def arena_stanzas
      %(
        provider "powerdns" {
          api_key    = "#{configuration.api_key}"
          server_url = "#{configuration.server_url}"
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

    def blueprint_stanzas
      scale do |i|
        %(
          resource "powerdns_record" "#{blueprint_identifier}-#{i + 1}" {
            zone    = "#{universe.host}"
            name    = "#{blueprint_identifier}-#{i + 1}.#{universe.host}"
            type    = "AAAA"
            ttl     = #{ttl}
            records = [${var.ip_address}]
          }
        )
      end
    end
  end
end
