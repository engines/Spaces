require_relative '../../stanzas/resource'

module Provisioning
  module Containers
    module Docker
      module Stanzas
        class Resource < ::Provisioning::Containers::Stanzas::Resource

          def q(identifier, container, iteration)
            %Q(
              resource "docker_container" "#{identifier}_#{iteration}" {
                name  = "#{identifier}_#{iteration}"
                image = "#{container.image}"
              }
            )
          end

        end
      end
    end
  end
end
