module Artifacts
  module Terraform
    module Aws
      module IamRole
        class More < Snippet

          def content =
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
