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

            load_balancer {
              target_group_arn = aws_lb_target_group.#{application_identifier}.arn
              container_name   = "#{application_identifier}"
              container_port   = 8501
            }
          )
        end

      end
    end
  end
end
