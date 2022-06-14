require_relative 'capsule_stanza'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceStanza < CapsuleStanza
        include TaskDefining

        def more_snippets
          %(
            task_definition = aws_ecs_task_definition.#{application_identifier}.arn

            ordered_placement_strategy {
              type  = "binpack"
              field = "cpu"
            }
          )
        end

      end
    end
  end
end
