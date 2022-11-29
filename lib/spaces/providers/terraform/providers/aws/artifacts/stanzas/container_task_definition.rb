require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerTaskDefinitionStanza < ResourceStanza

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

        def more_snippets = ContainerTaskDefinition::More.new(self).content

        def compatibilities =
          "#{container_services.map { |s| launch_type_for(s).to_s }.uniq}"

        def launch_type_for(r) = (
          r.configuration&.launch_type || ContainerServiceStanza.launch_type
        )

        def definition_snippets = ContainerTaskDefinition::Definition.new(self).content

      end
    end
  end
end
