require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class IamRole < Hash

          def more_snippets =
            {
              assume_role_policy: {
                Version: "2012-10-17",
                Statement: [
                  {
                    Action: "sts:AssumeRole",
                    Effect: "Allow",
                    Sid: "",
                    Principal: {
                      Service: "ecs-tasks.amazonaws.com"
                    }
                  }
                ]
              }
            }

        end
      end
    end
  end
end
