module Artifacts
  module Terraform
    module Aws
      module LoadBalancer
        class TargetGroup < Snippet

          def content =
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
