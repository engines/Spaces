require_relative '../../stanzas/resource'

module Provisioning
  module Containers
    module LXD
      module Stanzas
        class Resource < ::Provisioning::Containers::Stanzas::Resource

          def q(identifier, container, iteration)
            %Q(
              resource "lxd_container" "#{identifier}_#{iteration}" {
                name      = "#{identifier}_#{iteration}"
                image     = "#{container.image}"
                ephemeral = false

                device {
                  name  = "root"
                  type  = "disk"

                  properties  = {
                    "path" = "/"
                    "pool" = "default"
                  }
                }

                config = {
                  "boot.autostart" = true
                }
              }
            )
          end

        end
      end
    end
  end
end
