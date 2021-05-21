module Providers
  class Docker < ::Providers::Provider
    class Image < ::Providers::Image

      class << self
        def features; [:name, :output_image, :privileged] ;end
      end

      def privileged; struct.privileged || derived_features[:privileged] ;end

      # PACKER-SPECIFIC?
      def export
        duplicate(struct).tap { |m| m[:export_path] = "#{identifier}.tar" }
      end

      # PACKER-SPECIFIC?
      def commit
        duplicate(struct).tap { |m| m[:commit] = true }
      end

      # PACKER-SPECIFIC
      def post_processor_artifacts
        {
          type: "#{type}-tag",
          repository: image,
          tags: default_tag
        }
      end

      protected

      # PACKER-SPECIFIC?
      def derived_features
        @derived_features ||= {
          name: default_name,
          output_image: default_output_image,
          privileged: false
        }
      end

    end
  end
end
