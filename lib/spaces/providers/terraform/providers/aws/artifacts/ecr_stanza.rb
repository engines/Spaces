module Artifacts
  module Terraform
    module Aws
      class EcrStanza < ::Artifacts::Stanza

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
