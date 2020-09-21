require_relative '../image'

module Packing
  module Images
    module LXD
      class LXD < Image

        def default_resolution
          @default_resolution ||= {
            name: '{{user `suite`}}',
            output_image: 'spaces/models/{{user `suite`}}/base/{{user `datestamp`}}{{user `tag`}}',
            publish_properties: {
              description: 'Spaces {{user `suite`}} image',
              aliases: '{{user `suite`}}',
              architecture: 'amd64',
              os: 'devuan',
              emission: 'Devuan GNU/Linux 3.0'
            }
          }
        end

      end
    end
  end
end
