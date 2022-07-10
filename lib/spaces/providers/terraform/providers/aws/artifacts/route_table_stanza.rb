require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < ResourceStanza

        def configuration_snippet =
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
            route {
              cidr_block = "0.0.0.0/0"
              gateway_id = aws_internet_gateway.#{configuration.gateway_binding}.id
            }
          )

        def configuration_hash =
          super.without(:vpc_binding, :gateway_binding)

        def default_configuration =
          OpenStruct.new(
            vpc_binding: :vpc,
            gateway_binding: :'internet-gateway'
          )

      end
    end
  end
end
