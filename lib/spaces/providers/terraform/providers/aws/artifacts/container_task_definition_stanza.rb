require_relative 'resources_stanza'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < ResourcesStanza
        include TaskDefining

        def more_snippets
          %(
            container_definitions = jsonencode([
              #{definition_snippets}
            ])
          )
        end

        def definition_snippets
          #TODO: assumes one stanza for all container services in the arena
          arena.compute_resolutions_for(:container_service).map do |r|
            definition_snippet_for(r)
          end.join(",\n")
        end

        def definition_snippet_for(r)
          %(
            {
              #{hash_for(r).to_hcl(enclosed:false)}
              portMappings = [
                #{ports_mappings_for(r)}
              ]
            }
          )
        end

        def hash_for(r)
          {
            name: r.application_identifier,
            image: r.application_identifier,
          }.
            merge(task_configuration_hash_for(r)).
            merge(dimensions_hash_for(r))
        end

        def task_configuration_hash_for(r)
          h = r.configuration&.to_h_deep
          task_definition_keys.inject({}) do |m, k|
            m.tap do
              m[k] = h[k]
            end
          end
        end

        def dimensions_hash_for(r)
          r.dimensions&.struct&.to_h_deep
        end

        def ports_mappings_for(r)
          r.ports&.map do |p|
            p.struct.to_h_deep.transform_keys do |k|
              k.camelize.downcase_first
            end
          end.to_hcl(enclosed: false)
        end

        def default_configuration
          OpenStruct.new(
            family: :service
          )
        end

      end
    end
  end
end
