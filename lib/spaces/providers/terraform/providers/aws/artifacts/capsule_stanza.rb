module Artifacts
  module Terraform
    module Aws
      class CapsuleStanza < ::Artifacts::Terraform::CapsuleStanza

        def snippets
          %(
            resource "aws_ecr_repository" "aws-ecr" {
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
