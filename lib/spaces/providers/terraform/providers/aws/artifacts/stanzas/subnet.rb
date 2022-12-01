module Artifacts
  module Terraform
    module Aws
      class SubnetStanza < ::Artifacts::Aws::SubnetStanza

        def name_snippet = nil
        def more_snippets = Subnet::More.new(self).content

      end
    end
  end
end
