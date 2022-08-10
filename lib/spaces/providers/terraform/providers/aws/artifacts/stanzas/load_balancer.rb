require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerStanza < ResourceStanza
        def configuration_snippet =
          %(
            subnets         = #{subnet_array_ids}
            security_groups = #{security_group_array_ids}
			#{depends_on_snippet}
          )

        def subnet_array_ids =
          configuration.subnets.map do |s|
            "aws_subnet.#{arena_resource_qualification_for(s)}.id"
          end

        def security_group_array_ids =
          configuration.security_groups.map do |s|
            "aws_security_group.#{arena_resource_qualification_for(s)}.id"
          end
  
         def subnet_array =
          configuration.subnets.map do |s|
            "aws_subnet.#{arena_resource_qualification_for(s)}"
          end

        def security_group_array =
          configuration.security_groups.map do |s|
            "aws_security_group.#{arena_resource_qualification_for(s)}"
          end
  

      def depends_on_snippet =
		"depends_on = [#{security_group_array.concat(subnet_array)}]"		
       
      end
    end
  end
end
