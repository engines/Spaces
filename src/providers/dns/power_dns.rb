module Providers
  class PowerDns < ::Associations::Dns
    def arena_stanzas
STDERR.puts("power arena_stanzas")
      %(
        provider "powerdns" {
          api_key    = "#{api_key}"
          server_url = "#{server_url}"
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
            records = ["<---ipv6_address???--->"]
          }
        )
      end
    end

    def ttl
      120
    end

    def server_url
      'http://[fd61:d025:74d7:f46a::ffff]:8081/api/v1'
    end

    def api_key
      '369db357c9599dbee19400aaf1d14f98a5e8bb902f3c69a271f0cbacecb1126f'
    end
  end
end
