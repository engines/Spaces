require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class TaskDefinitionStanza < CapsuleStanza

        def resource_type; :ecs_task_definition ;end

      end
    end
  end
end
