require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceClusterStanza < ResourceStanza
        include Named

        def tags_snippet ;end

      end
    end
  end
end
