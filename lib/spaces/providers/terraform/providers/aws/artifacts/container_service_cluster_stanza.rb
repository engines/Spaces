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
                  kms_key_id = #{configuration&.kms_key_id}
                  logging    = "#{configuration&.logging}"

                  log_configuration {
                    cloud_watch_encryption_enabled = #{configuration&.logging_encryption_enabled}
                    cloud_watch_log_group_name     = #{configuration&.log_group_name}
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
