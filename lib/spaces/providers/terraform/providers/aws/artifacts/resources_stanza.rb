require_relative 'stanza'

module Artifacts
  module Terraform
    module Aws
      class ResourcesStanza < Stanza

        class << self

          def resource_type_map
            {
              application_load_balancer: :alb,
              cluster_key: :kms_key,
              container_definition: :ecs_container_definition,
              container_registry: :ecr_repository,
              container_service_cluster: :ecs_cluster,
              container_task_definition: :ecs_task_definition,
              load_balancer_listener: :lb_listener,
              load_balancer_target_group: :lb_target_group,
              log_group: :cloudwatch_log_group
            }
          end
        end

        delegate resource_type_map: :klass

      end
    end
  end
end
