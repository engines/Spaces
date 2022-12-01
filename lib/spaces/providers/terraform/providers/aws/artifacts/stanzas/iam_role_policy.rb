module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyStanza < ::Artifacts::Aws::IamRolePolicyStanza

        def more_snippets = IamRole::Policy.new(self).content

      end
    end
  end
end
