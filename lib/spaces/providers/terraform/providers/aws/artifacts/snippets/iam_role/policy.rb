module Artifacts
  module Terraform
    module Aws
      module IamRole
        class Policy < Snippet

          def content =
            %(
              role = aws_iam_role.#{qualification_for(:role_binding)}.id

              policy = jsonencode({
                Version = "2012-10-17"
                Statement = [
                  {
                    Action = [
                      "ec2:Describe*",
                    ]
                    Effect   = "Allow"
                    Resource = "*"
                  },
                ]
              })
            )

        end
      end
    end
  end
end
