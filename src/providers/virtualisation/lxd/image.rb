module Providers
  class Lxd < ::Divisions::Provider
    class Image < ::Divisions::Image

      class << self
        def inflatables; [:name, :output_image, :publish_properties] ;end
      end

      def publish_properties; struct.publish_properties || defaults[:publish_properties] ;end

      protected

      def defaults
        @defaults ||= {
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

      def default_name; super.gsub('/', '-') ;end

    end
  end
end
