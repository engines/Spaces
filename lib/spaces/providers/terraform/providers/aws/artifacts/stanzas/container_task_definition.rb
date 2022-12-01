module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < ::Artifacts::Aws::ContainerTaskDefinitionStanza

        def name_snippet = nil
        def more_snippets = ContainerTaskDefinition::More.new(self).content

      end
    end
  end
end
