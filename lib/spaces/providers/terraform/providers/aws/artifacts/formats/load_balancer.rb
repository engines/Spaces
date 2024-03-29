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

          def subnet_identifiers =
            subnet_array.map { |s| "#{s}.id" }

          def security_group_identifiers =
            security_group_array.map { |g| "#{g}.id" }

          def subnet_array =
            configuration.subnets.map do |s|
              "aws_subnet.#{arena_resource_qualification_for(s)}"
            end

          def security_group_array =
            configuration.security_groups.map do |s|
              "aws_security_group.#{arena_resource_qualification_for(s)}"
            end

          def dependency_array = [security_group_array, subnet_array].flatten

        end
      end
    end
  end
end
