require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class TaskDefinitionStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_ecs_task_definition" "#{blueprint_identifier}" {
            }
          )
        end

      end
    end
  end
end
