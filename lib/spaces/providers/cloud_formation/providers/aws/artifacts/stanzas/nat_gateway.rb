require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class NatGatewayStanza < ResourceStanza

        def default_configuration =
          super.merge(
            subnet_binding: resource.identifier,
            allocation_binding: resource.identifier,
            internet_gateway_binding: :internet_gateway
          )

        def more_snippets =
          %(
            subnet_id = aws_subnet.#{qualification_for(:subnet_binding)}.id
            allocation_id = aws_eip.#{qualification_for(:allocation_binding)}.id

            depends_on = [
              aws_internet_gateway.#{qualification_for(:internet_gateway_binding)}
            ]
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
end
