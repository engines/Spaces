module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "aws_route_table" "public" {
              vpc_id = aws_vpc.aws-vpc.id

              tags = {
                Name        = "${var.app_name}-routing-table-public"
                Environment = var.app_environment
              }
            }

            resource "aws_route" "public" {
              route_table_id         = aws_route_table.public.id
              destination_cidr_block = "0.0.0.0/0"
              gateway_id             = aws_internet_gateway.aws-igw.id
            }

            resource "aws_route_table_association" "publica" {
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
