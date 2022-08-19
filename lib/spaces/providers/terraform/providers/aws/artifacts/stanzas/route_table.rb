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

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{arena_attachable_qualification_for(:vpc_binding)}.id
            route {
              cidr_block = "0.0.0.0/0"
              gateway_id = aws_internet_gateway.#{arena_attachable_qualification_for(:gateway_binding)}.id
            }
          )

      end
    end
  end
end
