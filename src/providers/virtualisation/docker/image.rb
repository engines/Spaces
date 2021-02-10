module Providers
  class Docker < ::Divisions::Provider
    class Image < ::Divisions::Image

      class << self
        def inflatables; [:name, :output_image, :privileged] ;end
      end

      def privileged; struct.privileged || defaults[:privileged] ;end

      def export
        duplicate(struct).tap { |m| m[:export_path] = "#{identifier}.tar" }
      end

      def commit
        duplicate(struct).tap { |m| m[:commit] = true }
      end

      def post_processor_stanzas
        {
          type: "#{type}-tag",
          repository: image,
          tags: default_tag
        }
      end

      protected

      def defaults
        @defaults ||= {
          name: default_name,
          output_image: default_output_image,
          privileged: false
        }
      end

    end
  end
end
