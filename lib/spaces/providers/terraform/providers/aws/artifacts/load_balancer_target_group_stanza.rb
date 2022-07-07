require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerTargetGroupStanza < ResourceStanza
<<<<<<< HEAD

        def more_snippets =
=======
		def configuration_snippet
			%(
             vpc_id = aws_vpc.#{configuration.vpc_binding}.id
			 subnets         = aws_subnet.public.*.id
  			 security_groups = [aws_security_group.lb.id]
             protocol = #{configuration.protocol}
             port = #{configuration.port}
            )
		end
        def more_snippets
>>>>>>> 6a416912a68f35c58e7c874a190c5397a9ec2aae
          %(
			
            health_check {
              healthy_threshold   = #{configuration.healthy_threshold}
              interval            = #{configuration.interval}
              protocol            = #{configuration.protocol}
              matcher             = #{configuration.matcher}
              timeout             = #{configuration.timeout}
              path                = #{configuration.health_check_path}
              unhealthy_threshold = #{configuration.unhealthy_threshold}
            }
          )
<<<<<<< HEAD

=======
        end
        def default_configuration
          OpenStruct.new(
            description: application_identifier,
				target_type: "ip",
				healthy_threshold: 3,		
      			interval: 300,
      			protocol: 'HTTP',
      			matcher: 200,
      			timeout: 3,
				unhealthy_threshold: 2,
				health_check_path: '/',				
			    path_pattern:  ["/*"]
          )
        end
>>>>>>> 6a416912a68f35c58e7c874a190c5397a9ec2aae
      end
    end
  end
end
