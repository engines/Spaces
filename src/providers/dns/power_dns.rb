module Providers
  class PowerDns < ::Associations::Dns
    def arena_stanzas
      %(
        provider "powerdns" {
          api_key    = "#{api_key}"
          server_url = "#{server_url}"
        }
      )
    end

    def providers_require
      %(
          powerdns = {
          version = "1.4.0"
          source = "pan-net/powerdns"
          }
       )

    end


    def provisioning_stanzas
      scale do |i|
        %(
          resource "powerdns_record" "#{blueprint_identifier}-#{i + 1}" {
            zone    = "#{universe.host}"
            name    = "#{blueprint_identifier}-#{i + 1}.#{universe.host}"
            type    = "AAAA"
            ttl     = #{ttl}
            records = ["${var.ip_address}]
          }
        )
      end
    end

    def ttl
      120
    end

    def server_url
      'http://192.168.20.46:8081/api/v1'
    end

    def api_key
      'FRsBS'
    end
  end
end
