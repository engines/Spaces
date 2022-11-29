require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ContainerRegistryStanza < ResourceStanza
        include Named

        class << self
          def default_configuration =
            super.merge(
              image_tag_mutability: 'IMMUTABLE'
            )
        end

        def snippets = super + policy_snippet + push_images_snippet

        def policy_snippet = ContainerRegistry::Policy.new(self).content

        def push_images_snippet = ContainerRegistry::PushImages.new(self).content

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
end
