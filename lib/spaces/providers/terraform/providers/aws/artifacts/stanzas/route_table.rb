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

        def nat_gateway? = resource.struct&.configuration&.gateway_type == 'nat'

        def default_configuration =
          super.merge(
            nat_gateway_binding: nat_gateway_identifier
          )

        def nat_gateway_identifier =
          if nat_gateway?
            :"#{resource.struct[:identifier] || configuration.gateway_binding}"
          end

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            route {
              cidr_block = "0.0.0.0/0"
              #{gateway}
            }
          )

        def gateway =
          unless nat_gateway?
            "gateway_id = aws_internet_gateway.#{qualification_for(:gateway_binding)}.id"
          else
            "nat_gateway_id = aws_nat_gateway.#{qualification_for(:nat_gateway_binding)}.id"
          end

        def more_snippets_keys = [:gateway_type]

      end
    end
  end
end
