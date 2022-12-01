module Artifacts
  module Terraform
    module Aws
      class SecurityGroupStanza < ::Artifacts::Aws::SecurityGroupStanza

        def more_snippets = SecurityGroup::More.new(self).content

      end
    end
  end
end
