require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class IamRolePolicy < Hcl

          def tags_snippet = nil

          def more_snippets =
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
