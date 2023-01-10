require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class IamRole < Hcl

          def more_snippets =
            %(
              assume_role_policy = jsonencode({
                Version = "2012-10-17"
                Statement = [
                  {
                    Action = "sts:AssumeRole"
                    Effect = "Allow"
                    Sid    = ""
                    Principal = {
                      Service = "ecs-tasks.amazonaws.com"
                    }
                  }
                ]
              })
            )

        end
      end
    end
  end
end
