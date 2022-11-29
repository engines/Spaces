require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class NatGatewayStanza < ResourceStanza

        def default_configuration =
          super.merge(
            subnet_binding: resource.identifier,
            allocation_binding: resource.identifier,
            internet_gateway_binding: :internet_gateway
          )

        def more_snippets = NatGateway::More.new(self).content

        def snippets =
          %(#{super}

            resource "aws_eip" "#{resource_identifier}" {
              vpc = true
            }
          )

      end
    end
  end
end
