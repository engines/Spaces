require_relative 'resource'

module Artifacts
  module Aws
    class DnsRecordStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            evaluate_target_health: true
          )
      end

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::DnsRecord.new(self)
      end

      def default_configuration =
        super.merge(
          load_balancer_binding: default_binding,
          zone_id: "#{arena.compute_provider.zone_identifier}"
        )

      def configuration_hash = super.without(:evaluate_target_health)

    end
  end
end
