module Adapters
  module CloudFormation
    module Docker
      class Volume < ::Adapters::CloudFormation::Volume

        def snippets =
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
