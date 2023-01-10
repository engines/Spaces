require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class LoadBalancerTargetGroup < Resource

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc,
              target_type: 'ip',
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

        def default_configuration = super.merge(port: default_port)

        def default_port = (emission.ports.first.host_port if emission.has?(:ports))

        def configuration_hash =
          super.without(
            :healthy_threshold,
            :interval,
            :matcher,
            :timeout,
            :path,
            :unhealthy_threshold,
            :health_check_path,
            :path_pattern
          )

      end
    end
  end
end
