require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class LoadBalancerListener < Hash

          def name_snippet = nil

          def more_snippets =
            {
              load_balancer_arn: "aws_lb.#{configuration.load_balancer}.arn",
              certificate_arn: "arn:aws:acm:ap-southeast-2:910122582945:certificate/487f72fc-0e54-4e57-82b2-fe152294cf29",

              default_action: {
                type: "forward",
                target_group_arn: "aws_lb_target_group.#{configuration.target_group}.arn"
              }
            }

        end
      end
    end
  end
end
