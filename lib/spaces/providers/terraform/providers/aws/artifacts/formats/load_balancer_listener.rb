require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class LoadBalancerListener < Hcl

          def name_snippet = nil

          def more_snippets =
            #TODO: derive certificate_arn from terraform HCL declaration of acm_certificate (currently a singleton)
            %(
              load_balancer_arn = aws_lb.#{configuration.load_balancer}.arn

              certificate_arn = "arn:aws:acm:ap-southeast-2:910122582945:certificate/487f72fc-0e54-4e57-82b2-fe152294cf29"

              default_action {
                type             = "forward"
                target_group_arn = aws_lb_target_group.#{configuration.target_group}.arn
              }
            )

        end
      end
    end
  end
end
