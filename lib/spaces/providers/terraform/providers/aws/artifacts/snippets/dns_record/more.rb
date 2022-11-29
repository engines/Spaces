module Artifacts
  module Terraform
    module Aws
      module DnsRecord
        class More < Snippet

          def content =
            %(
              alias {
                name                   = aws_lb.#{qualification_for(:load_balancer_binding)}.dns_name
                zone_id                = aws_lb.#{qualification_for(:load_balancer_binding)}.zone_id
                evaluate_target_health = #{configuration.evaluate_target_health}
              }
            )

        end
      end
    end
  end
end
