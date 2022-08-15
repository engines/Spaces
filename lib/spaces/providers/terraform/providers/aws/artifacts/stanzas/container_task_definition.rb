require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < ResourceStanza
        include TaskDefining

        class << self
          def default_configuration =
            super.merge(
              network_mode: :awsvpc,
              memory: 2048,
              cpus: 1024
            )
        end

        def default_configuration =
          super.merge(
            # family: :service
            family: :"#{application_identifier}"
          )

        def container_services =
          arena.compute_resolutions_for(:container_service).
            select { |s| s.application_identifier == blueprint_identifier }

        def more_snippets =
          %(
            requires_compatibilities = #{compatibilities}
            container_definitions = jsonencode([
              #{definition_snippets}
            ])
          )

        def compatibilities =
          "#{container_services.map { |s| launch_type_for(s).to_s }.uniq}"

        def launch_type_for(r) =
          r.configuration.launch_type || ContainerServiceStanza.launch_type

        def definition_snippets =
          container_services.map { |s| definition_snippet_for(s) }.join(",\n")

        def definition_snippet_for(r) =
          #TODO: hostPort must be the same as containerPort when netWorkMode is awsvpc
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
            name: r.image_identifier.hyphenated,
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
