module Artifacts
  module CloudFormation
    module Aws
      class CapsuleStanza < Stanza

        class << self

          def resource_type_map =
            {
              container_service: :ecs_service
            }

        end

        delegate resource_type_map: :klass

        def resource_type_here =
          resource_type_map[compute_service_identifier&.to_sym] ||
            qualifier.split('_')[0..-2].join('_')

      end
    end
  end
end
