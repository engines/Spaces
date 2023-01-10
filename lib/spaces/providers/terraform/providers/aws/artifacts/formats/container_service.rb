require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class ContainerService < Hcl

          def more_snippets =
            %(
              depends_on = [
                aws_lb.#{qualification_for(:load_balancer_binding)},
                aws_lb_listener.#{qualification_for(:listener_binding)}
              ]

              cluster = aws_ecs_cluster.#{qualification_for(:cluster_binding)}.id
              task_definition = aws_ecs_task_definition.#{qualification_for(:task_definition_binding)}.arn
              load_balancer {
                target_group_arn = aws_lb_target_group.#{qualification_for(:target_group_binding)}.arn
                container_name   = "#{resource_identifier}"
                container_port   = "#{ports.first.container_port}"
              }
              network_configuration {
                subnets = [aws_subnet.#{qualification_for(:subnet_binding)}.id]
                assign_public_ip = #{configuration.assign_public_ip}
                security_groups = [aws_security_group.#{qualification_for(:security_group_binding)}.id]
              }
            )

        end
      end
    end
  end
end
