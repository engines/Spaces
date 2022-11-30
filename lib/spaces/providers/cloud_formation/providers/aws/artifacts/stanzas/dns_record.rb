require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class DnsRecordStanza < ResourceStanza
        include Named

        class << self
          def default_configuration =
            super.merge(
              evaluate_target_health: true
            )
        end

        def default_configuration =
          super.merge(
            load_balancer_binding: default_binding,
            zone_id: "#{arena.compute_provider.zone_identifier}"
          )

        def tags_snippet = nil

        def more_snippets =
          {
            alias: {
              name: "aws_lb.#{qualification_for(:load_balancer_binding)}.dns_name",
              zone_id:  "aws_lb.#{qualification_for(:load_balancer_binding)}.zone_id",
              evaluate_target_health: configuration.evaluate_target_health
            }
          }

        def configuration_hash = super.without(:evaluate_target_health)

      end
    end
  end
end
