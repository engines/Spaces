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

      def snippets =
        %(#{super}

          resource "aws_eip" "#{resource_identifier}" {
            vpc = true
          }
        )

    end
  end
end
