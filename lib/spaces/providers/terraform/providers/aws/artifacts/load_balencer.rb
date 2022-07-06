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
			sn.push("aws_subnet.#{sn}.id")
			done
			r
        end

        def sg_array
			r = []
			configuration.subnets.each do |sg|
			sn.push("aws_security_group.#{sg}.id")
			done
			r
        end
      end
    end
  end
end
