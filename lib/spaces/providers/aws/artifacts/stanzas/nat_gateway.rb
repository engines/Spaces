require_relative 'resource'

module Artifacts
  module Aws
    class NatGatewayStanza < ResourceStanza

      def default_configuration =
        super.merge(
          subnet_binding: resource.identifier,
          allocation_binding: resource.identifier,
          internet_gateway_binding: :internet_gateway
        )

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::NatGateway.new(self)
      end

    end
  end
end
