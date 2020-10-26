module Providers
  class Lxd < ::Divisions::Provider
    class Image < ::Divisions::Image

      def default_resolution
        @default_resolution ||= {
          name: default_name,
          output_image: default_output_image,
          publish_properties: {
            description: "Spaces #{tenant.identifier} #{context_identifier} image",
            aliases: tenant.identifier,
            architecture: 'amd64',
            os: 'devuan',
            release: 'Devuan GNU/Linux 3.0'
          }
        }
      end

    end
  end
end
