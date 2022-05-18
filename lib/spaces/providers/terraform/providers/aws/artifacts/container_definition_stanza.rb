require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerDefinitionStanza < CapsuleStanza

        def resource_type; :ecs_container_definition ;end

      end
    end
  end
end
