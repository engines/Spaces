require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerStanza < ResourceStanza

        def configuration_snippet =
          %(
            subnets         = #{subnet_array}
            security_groups = #{security_group_array}
          )

        def subnet_array =
          configuration.subnets.map { |s| "aws_subnet.#{s}.id" }

        def security_group_array =
          configuration.security_groups.map { |s| "aws_security_group.#{s}.id" }

      end
    end
  end
end
