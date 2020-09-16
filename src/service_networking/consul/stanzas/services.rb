require_relative '../../../releases/stanza'

module ServiceNetworking
  module Consul
    module Stanzas
      class Services < ::ServiceNetworking::Stanzas::Services

        def q(binding)
          %Q(
            resource "consul_node" "#{binding.identifier}" {
              name    = "#{binding.identifier}"
              address = "<---ipv6_address???--->"
            }

            resource "consul_service" "#{binding.identifier}" {
              name = "#{binding.identifier}"
              node = "#{binding.identifier}"
              port = "#{binding.port}"
            }
          )
        end

      end
    end
  end
end
