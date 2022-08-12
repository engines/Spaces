require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerRegistryStanza < ResourceStanza
        include Named

        class << self
          def default_configuration =
            super.merge(
              image_tag_mutability: 'IMMUTABLE'
            )
        end

        def snippets = super + policy_snippet + push_images_snippet

        def policy_snippet =
          %(
            resource "aws_ecr_repository_policy" "#{application_identifier}" {
              repository = aws_ecr_repository.#{application_identifier}.name
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
            resource "null_resource" "#{application_identifier}-images-#{Time.now.to_i}" {
              provisioner "local-exec" {
                command = <<LINES
                  #{login_command} &&
                  #{image_push_commands}
                LINES
              }

              depends_on = [
                aws_ecr_repository_policy.#{application_identifier}
              ]
            }
          )

        def image_push_commands
          arena.compute_resolutions_for(:container_service).map do |r|
            "docker push #{arena.compute_repository_path}:#{r.image_identifier}"
          end.join(";\n")
        end

        def login_command =
          %(`aws ecr get-login | sed 's|https://||' | sed  '/-e none/s///'`)

      end
    end
  end
end
