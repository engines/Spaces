require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class LoadBalancerListener < Hash

          def name_snippet = nil

          def more_snippets =
            {
              load_balancer_arn: {
                  ref: reference_for(configuration.load_balancer, :load_balancer)
              },
              certificate_arn: certificate_arn,

              default_actions: [
                {
                  type: 'forward',
                  target_group_arn: {
                    ref: reference_for(configuration.target_group, :load_balancer_target_group)
                  }
                }
              ]
            }

          def reference_for(name, type) =
            [name, type_for(type)].compact.join('_').underscore.camelize

        end
      end
    end
  end
end
