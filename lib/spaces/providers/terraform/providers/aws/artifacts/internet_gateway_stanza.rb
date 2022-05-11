module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "aws_internet_gateway" "aws-igw" {
              vpc_id = aws_vpc.aws-vpc.id
              tags = {
                Name = "${var.app_name}-igw"
              }
            }
          )
        end

      end
    end
  end
end
