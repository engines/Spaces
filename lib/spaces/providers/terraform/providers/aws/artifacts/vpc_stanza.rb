module Artifacts
  module Terraform
    module Aws
      class VpcStanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "aws_vpc" "aws-vpc" {
              cidr_block           = "10.168.0.0/16"
              enable_dns_hostnames = true
              enable_dns_support   = true
              tags = {
                Name        = "${var.app_name}-vpc"
                Environment = var.app_environment
              }
            }
          )
        end

      end
    end
  end
end
