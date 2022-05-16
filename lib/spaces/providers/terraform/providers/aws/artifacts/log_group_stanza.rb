require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class LogGroupStanza < CapsuleStanza

        def snippets
          %(
            resource "aws_cloudwatch_log_group" "#{blueprint_identifier}" {
              name = "${var.app_name}-${var.app_environment}-logs"
              target_arn = arn:aws:logs:ap-southeast-2:*:log-group:/aws/lambda/*:*:*
              role_arn   = aws_iam_role.iam_for_cloudwatch.arn
              tags = {
                Application = var.app_name
              }
            }
          )
        end

      end
    end
  end
end
