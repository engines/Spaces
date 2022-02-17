module Adapters
  module Packer
    module Lxd
      class Image < ::Adapters::Image

        class << self
          def features; [:name, :output_identifier, :publish_properties] ;end
        end

        def publish_properties; struct.publish_properties || derived_features[:publish_properties] ;end

        protected

        def derived_features
          @derived_features ||= {
            name: default_identifier,
            output_image: default_output_identifier,
            publish_properties: {
              description: "Spaces #{tenant_identifier} #{context_identifier} image",
              aliases: tenant_identifier,
              architecture: 'amd64',
              os: 'devuan',
              release: 'Devuan GNU/Linux 3.0'
            }
          }
        end

        def tenant_identifier; :engines ;end

        def default_identifier; super.gsub('/', '-') ;end

      end
    end
  end
end
