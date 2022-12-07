require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class LoadBalancer < Hcl

          def more_snippets =
            %(
              subnets         = #{subnet_identifiers.to_hcl_without_quotes}
              security_groups = #{security_group_identifiers.to_hcl_without_quotes}
              depends_on      = #{dependency_array.to_hcl_without_quotes}
            )

        end
      end
    end
  end
end
