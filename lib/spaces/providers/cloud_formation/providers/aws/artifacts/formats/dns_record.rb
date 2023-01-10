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
                name: dns_name,
                zone_id: zone_id,
                evaluate_target_health: configuration.evaluate_target_health
              }
            }

          def dns_name =
            "!GetAtt #{qualification_for(:load_balancer_binding, :load_balancer)}.DNSName"

          def zone_id =
            "!GetAtt #{qualification_for(:load_balancer_binding, :load_balancer)}.ZoneId"

        end
      end
    end
  end
end
