require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class ContainerRegistry < Hcl

          def content = super + policy_snippet + push_images_snippet

          def policy_snippet =
            %(
              resource "aws_ecr_repository_policy" "#{resource_identifier}" {
                repository = aws_ecr_repository.#{resource_identifier}.name
                policy     = <<LINES
                {
                  "Version": "2008-10-17",
                  "Statement": [
                    {
                      "Sid": "adds full ecr access to the demo repository",
                      "Effect": "Allow",
                      "Principal": "*",
                      "Action": [
                        "ecr:BatchCheckLayerAvailability",
                        "ecr:BatchGetImage",
                        "ecr:CompleteLayerUpload",
                        "ecr:GetDownloadUrlForLayer",
                        "ecr:GetLifecyclePolicy",
                        "ecr:InitiateLayerUpload",
                        "ecr:PutImage",
                        "ecr:UploadLayerPart"
                      ]
                    }
                  ]
                }
                LINES
              }
            )

          def push_images_snippet =
            %(
              resource "null_resource" "#{images_resource_identifier}" {
                provisioner "local-exec" {
                  command = <<LINES
                    `#{login_command}` &&
                    #{image_push_commands}; echo 0
                  LINES
                }

                depends_on = [
                  aws_ecr_repository_policy.#{resource_identifier}
                ]
              }
            )

          def images_resource_identifier =
            super.abbreviated_to(maximum_identifier_length)

        end
      end
    end
  end
end
