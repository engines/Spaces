module Artifacts
  module Aws
    class ResourceTypeMap < ::Spaces::Thing

      class << self
        def type_map =
          {
            container_definition: :ecs_container_definition,

            container_registry: :ecr_repository,

            cluster_key: :kms_key,
            log_group: :cloudwatch_log_group
          }
      end

      delegate type_map: :klass

      def value(key) = type_map[key] || key

    end
  end
end
