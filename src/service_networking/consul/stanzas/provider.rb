require_relative '../../../releases/stanza'

module ServiceNetworking
  module Consul
    module Stanzas
      class Provider < ::ServiceNetworking::Stanzas::Provider

        def q
          %Q(
            provider "#{context.qualifier}" {
              address = "#{address}"
              datacenter = "#{data_center.identifier}"
            }
          )
        end

      end
    end
  end
end
