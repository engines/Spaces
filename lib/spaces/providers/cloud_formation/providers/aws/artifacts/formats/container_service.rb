require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class ContainerService < Hash

          def dependency_snippet =
            {
              depends_on: [
                qualification_for(:load_balancer_binding, :lb),
                qualification_for(:listener_binding, :lb_listener)
              ]
            }

        def more_snippets =
          {
            cluster: {
              ref: qualification_for(:cluster_binding, :ecs_cluster)
            },
            task_definition: {
              ref: qualification_for(:task_definition_binding, :ecs_task_definition)
            },
            load_balancers: [
              {
                target_group: qualification_for(:target_group_binding, :lb_target_group),
                container_name: resource_identifier,
                container_port: ports.first.container_port
              }
            ],
            network_configuration: {
              subnets: [qualification_for(:subnet_binding, :subnet)],
              assign_public_ip: configuration.assign_public_ip,
              security_groups: [qualification_for(:security_group_binding, :security_group)]
            }
          }

          def configuration_hash = super.without(:assign_public_ip)

        end
      end
    end
  end
end
