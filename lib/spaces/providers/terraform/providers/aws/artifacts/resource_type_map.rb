module Artifacts
  module Terraform
    module Aws
      class ResourceTypeMap < ::Artifacts::Aws::ResourceTypeMap

      class << self
        def type_map =
          super.merge(
            load_balancer: :lb
          )
      end

      delegate type_map: :klass

      end
    end
  end
end
