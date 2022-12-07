module Artifacts
  module Aws
    class ResourceTypeMap < ::Spaces::Thing

      class << self
        def type_map =
          {
            container_service: :ecs_service,
            container_definition: :ecs_container_definition,
            container_registry: :ecr_repository,
            container_task_definition: :ecs_task_definition,

            dns_record: :route53_record,

            load_balancer: :lb,
            load_balancer_listener: :lb_listener,
            load_balancer_target_group: :lb_target_group,

            container_service_cluster: :ecs_cluster,
            cluster_key: :kms_key,
            log_group: :cloudwatch_log_group
          }
      end

      delegate type_map: :klass

    end
  end
end
