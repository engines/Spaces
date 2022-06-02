require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceClusterStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_#{resource_type}" "#{application_identifier}" {
              name = "#{application_identifier}"

              configuration {
                execute_command_configuration {
                  kms_key_id = aws_kms_key.cluster-key.arn
                  logging    = "OVERRIDE"

                  log_configuration {
                    cloud_watch_encryption_enabled = #{configuration.enabled}
                    cloud_watch_log_group_name     = aws_cloudwatch_log_group.Dougs-cluster-logs.name
                  }
                }
              }
            }
          )
        end
      end
    end
  end
end
