require_relative '../../stanzas/records'

module Dns
  module PowerDns
    module Stanzas
      class Records < ::Dns::Stanzas::Records

        def q(collaboration, container, iteration)
          %Q(
            resource "powerdns_record" "#{container.identifier}-#{iteration}" {
              zone    = "#{universe.host}"
              name    = "#{container.identifier}-#{iteration}.#{universe.host}"
              type    = "AAAA"
              ttl     = #{context.ttl}
              records = ["<---ipv6_address???--->"]
            }
          )
        end

      end
    end
  end
end
