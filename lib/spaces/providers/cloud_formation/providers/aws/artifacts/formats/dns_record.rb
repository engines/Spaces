require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class DnsRecord < Hash

          def tags_snippet = nil

          def more_snippets =
            {
              alias: {
                name: "aws_lb.#{qualification_for(:load_balancer_binding)}.dns_name",
                zone_id:  "aws_lb.#{qualification_for(:load_balancer_binding)}.zone_id",
                evaluate_target_health: configuration.evaluate_target_health
              }
            }

        end
      end
    end
  end
end
