module Artifacts
  module Terraform
    module Aws
      class SubnetsStanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "aws_subnet" "private-app-subnet-1" {
              vpc_id            = aws_vpc.aws-vpc.id
              cidr_block        = 10.168.100.0/24

              tags = {
                Name        = "private-app-subnet-1"
              }
            }
            
            resource "aws_subnet" "private-app-subnet-2" {
              vpc_id            = aws_vpc.aws-vpc.id
              cidr_block        = 10.168.110.0/24

              tags = {
                Name        = "private-app-subnet-2"
              }
            }

            resource "aws_subnet" "public-subnet-1" {
              vpc_id                  = aws_vpc.aws-vpc.id
              cidr_block              = 10.168.10.0/24
              map_public_ip_on_launch = true

              tags = {
                Name        = "public-subnet-1"
              }
            }

            resource "aws_subnet" "public-subnet-2" {
              vpc_id                  = aws_vpc.aws-vpc.id
              cidr_block              = 10.168.20.0/24
              map_public_ip_on_launch = true

              tags = {
                Name        = "public-subnet-2"
              }
            }

            resource "aws_subnet" "public-subnet-3" {
              vpc_id                  = aws_vpc.aws-vpc.id
              cidr_block              = 10.168.30.0/24
              map_public_ip_on_launch = true

              tags = {
                Name        = "public-subnet-3"
              }
            }
          )
        end

      end
    end
  end
end
