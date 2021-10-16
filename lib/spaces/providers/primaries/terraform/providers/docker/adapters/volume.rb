module Adapters
  module Terraform
    module Docker
      class Volume < ::Adapters::Terraform::Volume

        def container_snippets
          %(
            volumes {
              volume_name = "#{volume_name}"
              container_path = "#{destination}"
            }
          )
        end

        def snippets_for(_)
          %(
            resource "docker_volume" "#{volume_name}"  {
              name = "#{volume_name}"
              driver = "local"
            }
          )
        end

      end
    end
  end
end
