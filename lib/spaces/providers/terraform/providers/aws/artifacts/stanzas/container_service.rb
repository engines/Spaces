module Artifacts
  module Terraform
    module Aws
      class ContainerServiceStanza < ::Artifacts::Aws::ContainerServiceStanza

        def more_snippets = ContainerService::More.new(self).content

      end
    end
  end
end
