require_relative '../../stanzas/provider'

module Dns
  module PowerDns
    module Stanzas
      class Provider < ::Dns::Stanzas::Provider

        def q
          %Q(
            provider "powerdns" {
              api_key    = #{context.api_key}
              server_url = #{context.server_url}
            }
          )
        end

      end
    end
  end
end
