require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class LoadBalencerStanza < ResourceStanza
        def configuration_snippet
          %(
           subnets         = #{subnets_array}
           security_groups = [aws_security_group.lb.id]
          )
        end
        def subnets_array
			r = []
			configuration.subnets.each do |sn|
			 r.push("aws_subnet.#{sn}.id")
			end
			r
        end

        def sg_array
			r = []
			configuration.subnets.each do |sg|
			 r.push("aws_security_group.#{sg}.id")
			end
			r
        end
      end
    end
  end
end
