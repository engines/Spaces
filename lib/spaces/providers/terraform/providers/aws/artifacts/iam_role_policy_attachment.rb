require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyAttachmentStanza < ResourceStanza

        class << self
          def default_configuration =
            OpenStruct.new(
              role_binding: :'iam-role'
            )
        end

        def configuration_snippet =
          %(
            role       = aws_iam_role.#{configuration.role_binding}.name
            policy_arn = aws_iam_role.#{configuration.role_binding}.arn
          )

        def tags_snippet = nil

      end
    end
  end
end
