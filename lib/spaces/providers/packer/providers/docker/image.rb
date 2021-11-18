module Adapters
  module Packer
    module Docker
      class Image < ::Adapters::Image

        class << self
          def features; [:identifier, :output_identifier, :privileged] ;end
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
            name: default_identifier,
            output_identifier: default_output_identifier,
            privileged: false
          }
        end

      end
    end
  end
end
