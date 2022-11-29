module Artifacts
  module Terraform
    module Aws
      module IamRole
        class PolicyAttachment < Snippet

          def content =
            %(
              role = aws_iam_role.#{qualification_for(:role_binding)}.name
            )

        end
      end
    end
  end
end
