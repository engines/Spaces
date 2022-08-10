require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyAttachmentStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              role_binding: :'iam-role'
            )
        end

        def configuration_snippet =
          %(
            role       = aws_iam_role.#{arena_attachable_qualification_for(:role_binding)}.id
            policy_arn = arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole
          )

        def tags_snippet = nil

      end
    end
  end
end
