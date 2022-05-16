require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerRegistryStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_ecr_repository" "#{blueprint_identifier}" {
              name = "${var.app_name}-${var.app_environment}-ecr"
              tags = {
                Name = "${var.app_name}-ecr"
              }
            }
          )
        end

      end
    end
  end
end
