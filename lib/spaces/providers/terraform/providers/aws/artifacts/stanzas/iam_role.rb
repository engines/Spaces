module Artifacts
  module Terraform
    module Aws
      class IamRoleStanza < ::Artifacts::Aws::IamRoleStanza

        def more_snippets = IamRole::More.new(self).content

      end
    end
  end
end
