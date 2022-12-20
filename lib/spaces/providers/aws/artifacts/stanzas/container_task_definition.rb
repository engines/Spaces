require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class ContainerTaskDefinition < Resource

        class << self
          def default_configuration =
            super.merge(
              network_mode: :awsvpc,
              memory: 2048,
              cpus: 1024,
              execution_role_binding: :'execution-role'
            )
        end

        def default_configuration =
          super.merge(
            family: :"#{application_identifier}"
          )

        def container_services =
          arena.compute_resolutions_for(:container_service).
            select { |s| s.application_identifier == blueprint_identifier }

        def compatibilities =
          "#{container_services.map { |s| launch_type_for(s).to_s }.uniq}"

        def launch_type_for(r) = (
          r.configuration&.launch_type || ContainerService.launch_type
        )

        def hash_for(r) =
          {
            name: r.image_identifier.hyphenated,
            image: "#{arena.image_registry_path}:#{r.image_identifier}",
            essential: true
          }.
            merge(dimensions_hash_for(r))

        def dimensions_hash_for(r) = r.dimensions&.struct&.deep_to_h

        def ports_mappings_for(r)
          r.ports&.map do |p|
            p.struct.deep_to_h.transform_keys do |k|
              k.camelize.downcase_first
            end
          end
        end

      end
    end
  end
end
