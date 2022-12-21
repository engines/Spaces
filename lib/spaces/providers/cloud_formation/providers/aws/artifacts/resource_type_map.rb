module Artifacts
  module CloudFormation
    module Aws
      class ResourceTypeMap < ::Artifacts::Aws::ResourceTypeMap

        class << self
          def type_map =
            super.merge(
              container_service: :'ECS::Service',
              container_service_cluster: :'ECS::Cluster',
              container_task_definition: :'ECS::TaskDefinition',

              load_balancer: :'ElasticLoadBalancingV2::LoadBalancer',
              load_balancer_listener: :'ElasticLoadBalancingV2::Listener',
              load_balancer_target_group: :'ElasticLoadBalancingV2::TargetGroup',

              iam_role: :'IAM::Role',
              iam_role_policy: :'IAM::RolePolicy',

              vpc: :'EC2::VPC',
              subnet: :'EC2::Subnet',
              internet_gateway: :'EC2::InternetGateway'
            )
        end

        delegate type_map: :klass

      end
    end
  end
end
