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
              security_group: :'EC2::SecurityGroup',
              internet_gateway: :'EC2::InternetGateway',
              nat_gateway: :'EC2::NatGateway',
              route_table: :'EC2::RouteTable',
              route_table_association: :'EC2::SubnetRouteTableAssociation',

              cluster_key: :'KMS::Key',
              log_group: :'Logs::LogGroup',

              dns_record: :'Route53::RecordSet'
            )
        end

        delegate type_map: :klass

      end
    end
  end
end
