module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyAttachmentStanza < ::Artifacts::Aws::IamRolePolicyAttachmentStanza

        def more_snippets = IamRole::PolicyAttachment.new(self).content

      end
    end
  end
end
