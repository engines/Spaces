require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceStanza < CapsuleStanza

        def resource_type; :ecs ;end

        def more_snippets
          %(
            cluster         = aws_ecs_cluster.abs.id ??
            task_definition = aws_ecs_task_definition.abs.arn ??
            iam_role        = aws_iam_role
            depends_on      = [aws_iam_role]

            ordered_placement_strategy {
              type  = "binpack"
              field = "cpu"
            }

            load_balancer {
              target_group_arn = aws_lb_target_group.abs.arn
              container_name   = "app"
              container_port   = 8501
            }
          )
        end

      end
    end
  end
end
