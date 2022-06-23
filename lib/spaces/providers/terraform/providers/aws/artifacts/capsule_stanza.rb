require_relative 'stanza'

module Artifacts
  module Terraform
    module Aws
      class CapsuleStanza < Stanza

        class << self

          def resource_type_map
            {
              container_service: :ecs_service
            }
          end
        end

        delegate resource_type_map: :klass

      end
    end
  end
end
