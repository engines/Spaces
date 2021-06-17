module Providers
  class Packer < ::ProviderAspects::Provider
    module Docker
      class Image < ::ProviderAspects::Image

        class << self
          def features; [:name, :output_name, :privileged] ;end
        end

        def privileged; struct.privileged || derived_features[:privileged] ;end

        def export
          duplicate(struct).tap { |m| m[:export_path] = "#{identifier}.tar" }
        end

        def commit
          duplicate(struct).tap { |m| m[:commit] = true }
        end

        protected

        def derived_features
          @derived_features ||= {
            name: default_name,
            output_name: default_output_name,
            privileged: false
          }
        end

      end
    end
  end
end
