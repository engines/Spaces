require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class LogGroupStanza < CapsuleStanza

        def resource_type; :cloudwatch_log_group ;end

        def more_snippets
          %(
            target_arn = arn:aws:logs:ap-southeast-2:*:log-group:/aws/lambda/*:*:*
            role_arn   = aws_iam_role.iam_for_cloudwatch.arn
          )
        end

      end
    end
  end
end
