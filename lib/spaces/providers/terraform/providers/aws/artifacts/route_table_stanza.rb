require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < CapsuleStanza

        def more_snippets
          %(
            resource "aws_route" "public" {
              route_table_id         = aws_route_table.public.id
              destination_cidr_block = "0.0.0.0/0"
              gateway_id             = aws_internet_gateway.aws-igw.id
            }

            resource "aws_route_table_association" "publica" { arena binding_identifier!!!!!
              subnet_id      = public-subnet-1
              route_table_id = aws_route_table.public.id
            }

            resource "aws_route_table_association" "publicb" {
              subnet_id      = public-subnet-2
              route_table_id = aws_route_table.public.id
            }

            resource "aws_route_table_association" "publicc" {
              subnet_id      = public-subnet-3
              route_table_id = aws_route_table.public.id
            }
          )
        end

      end
    end
  end
end
