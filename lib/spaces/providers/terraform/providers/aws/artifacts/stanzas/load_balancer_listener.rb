require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerListenerStanza < ResourceStanza

        def more_snippets =
          %(
            load_balancer_arn = aws_alb.application_load_balancer.id

            default_action {
              type             = "forward"
              target_group_arn = aws_lb_target_group.target_group.id
            }
          )

      end
    end
  end
end
