module Adapters
  module Packer
    module Docker
      class Image < ::Adapters::Image

        class << self
          def features = [:identifier, :output_identifier, :privileged]
        end

        def privileged = struct.privileged || derived_features[:privileged]

        def export
          duplicate(struct).tap { |m| m[:export_path] = "#{identifier}.tar" }
        end

        def commit
          duplicate(struct).tap { |m| m[:commit] = true }
        end

        protected

        def derived_features =
          {
            name: identifier,
            output_identifier: output_identifier,
            privileged: false
          }

      end
    end
  end
end
