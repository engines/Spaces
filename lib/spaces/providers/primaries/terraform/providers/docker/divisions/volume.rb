module Providers
  module Terraform
    module Docker
      class Volume < ::Adapters::Volume

        def device_stanzas
          %Q(
            volumes {
              volume_name = "#{volume_name}"
              container_path = "#{destination}"
            }
          )
        end

        def stanzas_for(_)
          %Q(
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
