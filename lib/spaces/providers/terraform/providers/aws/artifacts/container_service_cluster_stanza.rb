require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class ContainerServiceClusterStanza < ResourceStanza
        include Named

        def snippets
          %(
            resource "aws_#{resource_type}" "#{application_identifier}" {
              name = "#{application_identifier}"
            }
          )
        end
      end
    end
  end
end
