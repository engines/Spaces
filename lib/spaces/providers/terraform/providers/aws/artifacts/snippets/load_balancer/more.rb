module Artifacts
  module Terraform
    module Aws
      module LoadBalancer
        class More < Snippet

          def content =
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
