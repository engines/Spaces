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
          "#{resource_identifier}-images-#{Time.now.to_i}".abbreviated_to(maximum_identifier_length)

        def image_push_commands
          arena.compute_resolutions_for(:container_service).map do |r|
            "docker push #{arena.image_registry_path}:#{r.image_identifier}"
          end.join(";\n")
        end

        def login_command =
          %(aws ecr get-login-password | docker login --username AWS --password-stdin #{arena.compute_provider.image_registry_domain})

      end
    end
  end
end
