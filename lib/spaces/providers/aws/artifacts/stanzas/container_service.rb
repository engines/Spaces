require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class ContainerService < Capsule

        class << self
          def default_configuration =
            super.merge(
              cluster_binding: :'container-service-cluster',
              launch_type: :'FARGATE',
              assign_public_ip: true
            )

          def launch_type = default_configuration.launch_type
        end

        def default_configuration =
          super.merge(
            desired_count: emission.dimensions&.tasks || 1,
            security_group_binding: :security_group,
            task_definition_binding: default_binding,
            target_group_binding: default_binding,
            subnet_binding: "#{default_binding}-a",
            load_balancer_binding: default_binding,
            listener_binding: default_binding
          )

        def configuration_hash = super.without(:assign_public_ip)

      end
    end
  end
end
