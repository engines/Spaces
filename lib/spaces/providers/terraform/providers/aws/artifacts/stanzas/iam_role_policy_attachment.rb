require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyAttachmentStanza < ResourceStanza

        class << self
          def default_configuration =
            #FIX: use terraform HCL instead of AWS notation
            # why did the following not work?
            # aws_iam_role.#{qualification_for(:role_binding)}.arn
            super.merge(
              role_binding: :'iam-role',
              policy_arn: "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
            )
        end

        def more_snippets =
          %(
            role = aws_iam_role.#{qualification_for(:role_binding)}.id
          )

        def tags_snippet = nil

      end
    end
  end
end
