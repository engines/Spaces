require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class IamRolePolicyAttachment < Hash

          def name_snippet = nil
          def tags_snippet = nil

          def more_snippets =
            {
              role: "aws_iam_role.#{qualification_for(:role_binding)}.name"
            }

        end
      end
    end
  end
end
