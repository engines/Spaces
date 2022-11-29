module Artifacts
  module Terraform
    module Aws
      module ContainerRegistry
        class Policy < Snippet

          def content =
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

        end
      end
    end
  end
end
