require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerTargetGroupStanza < CapsuleStanza

        def resource_type; :lb_target_group ;end

        def more_snippets
          %(
            vpc_id = aws_vpc.#{vpc.blueprint_identifier}.id

            health_check {
              healthy_threshold   = "3"
              interval            = "300"
              protocol            = "HTTP"
              matcher             = "200"
              timeout             = "3"
              path                = "/v1/status"
              unhealthy_threshold = "2"
            }
          )
        end

      end
    end
  end
end
