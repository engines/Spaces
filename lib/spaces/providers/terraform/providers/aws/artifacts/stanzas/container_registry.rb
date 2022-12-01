module Artifacts
  module Terraform
    module Aws
      class ContainerRegistryStanza < ::Artifacts::Aws::ContainerRegistryStanza

        def snippets = super + policy_snippet + push_images_snippet

        def policy_snippet = ContainerRegistry::Policy.new(self).content

        def push_images_snippet = ContainerRegistry::PushImages.new(self).content

      end
    end
  end
end
