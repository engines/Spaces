require_relative 'resource_stanza'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < ResourceStanza
        include TaskDefining

        class << self
          def default_configuration =
            OpenStruct.new(
              family: :service,
              network_mode: :awsvpc,
              memory: 2048,
              cpus: 1024
            )
        end

        def more_snippets =
          %(
            requires_compatibilities = ["FARGATE"]
            container_definitions = jsonencode([
              #{definition_snippets}
            ])
          )

        def definition_snippets
          #TODO: assumes one stanza for all container services in the arena
          arena.compute_resolutions_for(:container_service).map do |r|
            definition_snippet_for(r)
          end.join(",\n")
        end

        def definition_snippet_for(r) =
          %(
            {
              #{with_tailored_keys(hash_for(r)).to_hcl(enclosed:false)}
              networkMode = "#{configuration.network_mode}"
              portMappings = [
                #{ports_mappings_for(r)}
              ]
            }
          )

        def hash_for(r) =
          {
            name: r.application_identifier,
            image: r.image_identifier,
          }.
            merge(task_configuration_hash_for(r)).
            merge(dimensions_hash_for(r))

        def task_configuration_hash_for(r)
          h = r.configuration&.to_h_deep
          task_definition_keys.inject({}) do |m, k|
            m.tap do
              m[k] = h[k]
            end
          end
        end

        def dimensions_hash_for(r) = r.dimensions&.struct&.to_h_deep

        def ports_mappings_for(r)
          r.ports&.map do |p|
            p.struct.to_h_deep.transform_keys do |k|
              k.camelize.downcase_first
            end
          end.to_hcl(enclosed: false)
        end

      end
    end
  end
end
