require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class DnsRecord < Hcl

          def tags_snippet = nil

          def more_snippets =
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
