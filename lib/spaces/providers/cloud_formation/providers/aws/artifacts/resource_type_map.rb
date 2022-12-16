module Artifacts
  module CloudFormation
    module Aws
      class ResourceTypeMap < ::Artifacts::Aws::ResourceTypeMap

        class << self
          def type_map =
            super.merge(
              load_balancer: :'ElasticLoadBalancing::LoadBalancer'
            )
        end

        delegate type_map: :klass

      end
    end
  end
end
