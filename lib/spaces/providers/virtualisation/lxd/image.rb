module Providers
  class Lxd < ::Providers::Provider
    class Image < ::Providers::Image

      class << self
        def features; [:name, :output_image, :publish_properties] ;end
      end

      def inflated; self ;end
      def deflated; self ;end

      def publish_properties; struct.publish_properties || derived_features[:publish_properties] ;end

      protected

      def derived_features
        @derived_features ||= {
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
