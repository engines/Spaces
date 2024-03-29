require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class LoadBalancerTargetGroup < Hash

          def more_snippets =
            {
              vpc_id: qualification_for(:vpc_binding, :vpc),
              health_check: {
                healthy_threshold: configuration.healthy_threshold,
                interval: configuration.interval,
                protocol: configuration.protocol,
                matcher: configuration.matcher,
                timeout: configuration.timeout,
                path: configuration.health_check_path,
                unhealthy_threshold: configuration.unhealthy_threshold
              }
            }

        end
      end
    end
  end
end
