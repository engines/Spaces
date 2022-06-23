require_relative 'resources_stanza'

module Artifacts
  module Terraform
    module Aws
      class IamRoleStanza < ResourcesStanza
        include Named

        def more_snippets
          %(
            assume_role_policy = jsonencode({
              Version = "2012-10-17"
              Statement = [
                {
                  Action = "sts:AssumeRole"
                  Effect = "Allow"
                  Sid    = ""
                  Principal = {
                    Service = "ec2.amazonaws.com"
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
