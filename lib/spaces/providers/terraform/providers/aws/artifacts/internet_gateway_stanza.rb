require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_internet_gateway" "#{blueprint_identifier}" {
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
