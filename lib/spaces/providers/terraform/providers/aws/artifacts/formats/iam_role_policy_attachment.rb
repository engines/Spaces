require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class IamRolePolicyAttachment < Hcl

          def name_snippet = nil
          def tags_snippet = nil

          def more_snippets =
            %(
              role = aws_iam_role.#{qualification_for(:role_binding)}.name
            )

        end
      end
    end
  end
end
