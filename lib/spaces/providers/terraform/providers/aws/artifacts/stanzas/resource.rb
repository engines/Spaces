module Artifacts
  module Terraform
    module Aws
      class ResourceStanza < Stanza

        class << self
          def resource_type_map =
            {
              container_definition: :ecs_container_definition,
              container_registry: :ecr_repository,
              container_task_definition: :ecs_task_definition,

              load_balancer: :lb,
              load_balancer_listener: :lb_listener,
              load_balancer_target_group: :lb_target_group,

              container_service_cluster: :ecs_cluster,
              cluster_key: :kms_key,
              log_group: :cloudwatch_log_group
            }

        end

        delegate resource_type_map: :klass

        alias_method :resource, :holder

        def resource_identifier = [arena.identifier, resource.identifier].join('-').hyphenated

        def resource_type_here =
          resource_type_map[resource_type.to_sym] || resource_type

        def configuration
          @configuration ||= default_configuration.merge(resource.configuration)
        end

        def resource_type = resource.type

      end
    end
  end
end
