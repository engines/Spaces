require_relative '../../../releases/stanza'

module ServiceNetworking
  module Consul
    module Stanzas
      class Keys < ::ServiceNetworking::Stanzas::Keys

        def q(binding)
          %Q(
            resource "consul_key_prefix" "#{terraform_identifier_for(binding)}" {
              datacenter = "#{data_center.identifier}"

              path_prefix = "#{path_prefix_for(binding)}"

              subkeys = {
                #{subkeys_for(binding)}
              }
            }
          )
        end

        def subkeys_for(binding)
          binding.variables.to_h.map { |k, v| %Q("#{k}" = "#{v}") }.join("\n")
        end

        def data_center
          universe.data_centers.default
        end

      end
    end
  end
end
