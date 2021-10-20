module Adapters
  module Terraform
    module Docker
      class Volume < ::Adapters::Terraform::Volume

        def snippets
          %(
            volumes {
              volume_name = "#{volume_name}"
              container_path = "#{destination}"
            }
          )
        end

      end
    end
  end
end
