module Artifacts
  module Terraform
    module Aws
      module ContainerRegistry
        class PushImages < Snippet

          def content =
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

        end
      end
    end
  end
end
