require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class IamRolePolicy < Hash

          def tags_snippet = nil

          def more_snippets =
            {
              role: qualification_for(:role_binding, :iam_role),

              policy: {
                Version: "2012-10-17",
                Statement: [
                  {
                    Action: [
                      "ec2:Describe*"
                    ],
                    Effect: "Allow",
                    Resource: "*"
                  }
                ]
              }
            }

        end
      end
    end
  end
end
