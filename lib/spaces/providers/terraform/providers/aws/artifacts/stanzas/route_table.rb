require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc,
              gateway_binding: :'internet-gateway'
            )
        end

        def configuration_snippet =
          %(
            vpc_id = aws_vpc.#{qualifier_for(:vpc_binding)}.id
            route {
              cidr_block = "0.0.0.0/0"
              gateway_id = aws_internet_gateway.#{qualifier_for(:gateway_binding)}.id
            }
          )

        def configuration_hash =
          super.without(:vpc_binding, :gateway_binding)

      end
    end
  end
end
