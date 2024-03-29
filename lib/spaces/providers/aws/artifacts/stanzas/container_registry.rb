require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class ContainerRegistry < Resource

        class << self
          def default_configuration =
            super.merge(
              image_tag_mutability: 'IMMUTABLE'
            )
        end

        def images_resource_identifier =
          "#{resource_identifier}-images-#{Time.now.to_i}"

        def image_push_commands
          arena.compute_resolutions_for(:container_service).map do |r|
            "docker push #{arena.image_registry_path}:#{r.image_identifier}"
          end.join(";\n")
        end

        def login_command =
          %(aws ecr get-login-password | docker login --username AWS --password-stdin #{arena.compute_provider.image_registry_domain})

      end
    end
  end
end
