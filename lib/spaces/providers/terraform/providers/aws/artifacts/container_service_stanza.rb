require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceStanza < CapsuleStanza

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

        def task_definition_hash
          h = configuration&.to_h_deep
          task_definition_keys.inject({}) do |m, k|
            m.tap do
              m[k] = h[k]
            end
          end
        end

        def configuration_hash
          super.without(*task_definition_keys)
        end

        def task_definition_keys
          [
            :cpu,
            :memory,
            :essential,
            :container_port,
            :host_port
          ]
        end

      end
    end
  end
end
