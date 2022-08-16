require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceClusterStanza < ResourceStanza
        include Named

        def tags_snippet = nil

      end
    end
  end
end
