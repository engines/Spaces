require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class LoadBalancerTargetGroupStanza < ResourceStanza

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

        def default_port = (ports.first.host_port if emission.has?(:ports))

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{arena_attachable_qualification_for(:vpc_binding)}.id

            health_check {
              healthy_threshold   = #{configuration.healthy_threshold}
              interval            = #{configuration.interval}
              protocol            = "#{configuration.protocol}"
              matcher             = #{configuration.matcher}
              timeout             = #{configuration.timeout}
              path                = "#{configuration.health_check_path}"
              unhealthy_threshold = #{configuration.unhealthy_threshold}
            }
          )

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
