require_relative 'resource'

module Artifacts
  module Aws
    class ContainerRegistryStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            image_tag_mutability: 'IMMUTABLE'
          )
      end

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::ContainerRegistry.new(self)
      end

      def images_resource_identifier =
        "#{resource_identifier}-images-#{Time.now.to_i}".abbreviated_to(maximum_identifier_length)

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
