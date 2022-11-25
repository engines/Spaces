require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class LoadBalancerListenerStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              port: 443,
              protocol: 'HTTPS',
              ssl_policy: 'ELBSecurityPolicy-2016-08'
            )
        end

        def default_configuration =
          super.merge(
            target_group: resource_identifier,
            load_balancer: resource_identifier
          )

        def more_snippets =
          #TODO: derive certificate_arn from terraform HCL declaration of acm_certificate (currently a singleton)
          {
            load_balancer_arn: "aws_lb.#{configuration.load_balancer}.arn",
            certificate_arn: "arn:aws:acm:ap-southeast-2:910122582945:certificate/487f72fc-0e54-4e57-82b2-fe152294cf29",

            default_action: {
              type: "forward",
              target_group_arn: "aws_lb_target_group.#{configuration.target_group}.arn"
            }
          }

        def configuration_hash = super.without(:target_group, :load_balancer)

      end
    end
  end
end
