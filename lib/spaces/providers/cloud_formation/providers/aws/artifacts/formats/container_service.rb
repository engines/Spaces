require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class ContainerService < Hash

          def resource_identifier =
            holder.resource_identifier.as_cloud_formation_name

          def dependency_snippet =
            {
              depends_on: [
                qualification_for(:load_balancer_binding, :load_balancer),
                qualification_for(:listener_binding, :load_balancer_listener)
              ]
            }

        def more_snippets =
          {
            cluster: {
              ref: qualification_for(:cluster_binding, :container_service_cluster)
            },
            task_definition: {
              ref: qualification_for(:task_definition_binding, :container_task_definition)
            },
            load_balancers: [
              {
                target_group: qualification_for(:target_group_binding, :load_balancer_target_group),
                container_name: resource_identifier,
                container_port: resolution.ports.first.container_port
              }
            ],
            network_configuration: {
              subnets: [qualification_for(:subnet_binding, :subnet)],
              assign_public_ip: configuration.assign_public_ip,
              security_groups: [qualification_for(:security_group_binding, :security_group)]
            }
          }

          # def qualification_for(attachable, type=nil) =
          #   [resource_identifier, super(attachable), type_for(type),].compact.join('_').as_cloud_formation_name

          def configuration_hash = super.without(:assign_public_ip)

        end

        Service = ContainerService
      end
    end
  end
end
