require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class IamRoleStanza < ResourceStanza
        include Named

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
