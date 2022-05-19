require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < CapsuleStanza

        def more_snippets
          %(
            route {
              cidr_block = "10.111.111.0/24"
              gateway_id = aws_internet_gateway.VPC_A-gw.id
            }

            route {
              cidr_block = "10.111.222.0/24"
              gateway_id = aws_internet_gateway.VPC_A-gw.id
            }

            route {
              cidr_block = "0.0.0.0/0"
              gateway_id = aws_internet_gateway.VPC_A-gw.id
            }
          )
        end

      end
    end
  end
end
