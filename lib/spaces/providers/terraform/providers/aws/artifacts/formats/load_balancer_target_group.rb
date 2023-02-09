require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class LoadBalancerTargetGroup < Hcl

          def more_snippets =
            %(
              vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id

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

        end
      end
    end
  end
end
