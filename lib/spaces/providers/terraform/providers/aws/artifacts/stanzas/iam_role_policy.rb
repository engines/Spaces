require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class IamRolePolicyStanza < ResourceStanza
        include Named

        class << self
          def default_configuration =
            super.merge(
              role_binding: :'iam-role'
            )
        end

        def more_snippets = IamRole::Policy.new(self).content

        def tags_snippet = nil

      end
    end
  end
end
