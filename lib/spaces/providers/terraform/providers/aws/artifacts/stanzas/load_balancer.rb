require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerStanza < ResourceStanza
        def configuration_snippet =
          %(
            subnets         = #{subnet_array}
            security_groups = #{security_group_array}
			#{depends_on_snippet}
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

      def depends_on_snippet
        configuration.security_groups.map do |s|
          "aws_security_group.#{arena_resource_qualification_for(s)}"
        end
        configuration.subnets.map do |s|
          "aws_subnet.#{arena_resource_qualification_for(s)}"
        end
      end
    end
  end
end
