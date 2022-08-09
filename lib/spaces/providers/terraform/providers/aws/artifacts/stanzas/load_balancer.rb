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
          configuration.subnets.map do |s|
            "aws_subnet.#{arena_resource_qualification_for(s)}.id"
          end

        def security_group_array =
          configuration.security_groups.map do |s|
            "aws_security_group.#{arena_resource_qualification_for(s)}.id"
          end

      end
    end
  end
end
