require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class VpcStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_vpc" "#{blueprint_identifier}" {
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