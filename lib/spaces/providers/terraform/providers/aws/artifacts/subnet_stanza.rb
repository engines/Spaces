require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_subnet" "#{blueprint_identifier}" {
              vpc_id            = aws_vpc.aws-vpc.id
              cidr_block        = 10.168.100.0/24

              tags = {
                Name        = "private-app-subnet-1"
              }
            }
          )
        end

      end
    end
  end
end
