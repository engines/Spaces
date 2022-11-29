require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class IamRoleStanza < ResourceStanza
        include Named

        def more_snippets = IamRole::More.new(self).content

      end
    end
  end
end
