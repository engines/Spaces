module Artifacts
  module Terraform
    module Aws
      class ResourceTypeMap < ::Artifacts::Aws::ResourceTypeMap

      class << self
        def type_map =
          super.merge(
            container_service: :ecs_service,
            container_service_cluster: :ecs_cluster,
            container_task_definition: :ecs_task_definition,

            load_balancer: :lb
          )
      end

      delegate type_map: :klass

      end
    end
  end
end
