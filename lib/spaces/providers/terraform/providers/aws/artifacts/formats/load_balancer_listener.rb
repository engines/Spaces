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

              certificate_arn = "#{certificate_arn}"

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
