require_relative 'capsule_stanza'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < CapsuleStanza
        include TaskDefining

        def more_snippets
          %(
            container_definitions = jsonencode([
              #{task_definition_snippets}
            ])
          )
        end

        def task_definition_snippets
          #TODO: assumes one stanza for all container services in the arena
          arena.compute_resolutions_for(:container_service).map do |r|
            task_definition_snippet_for(r)
          end.join(,"\n")
        end

        def task_definition_snippet_for(resolution)
          %(
            {
              #{task_definition_hash_for(resolution).to_hcl.join("\n")}
            }
          )
        end

        def task_definition_hash_for(resolution)
          h = resolution.configuration&.to_h_deep
          task_definition_keys.without(*port_mapping_keys).inject({}) do |m, k|
            m.tap do
              m[k] = h[k]
            end
          end
        end

        def port_mapping_keys
          #TODO: assumes one set of port mappings per task definition
          [
            :container_port,
            :host_port
          ]
        end

      end
    end
  end
end
