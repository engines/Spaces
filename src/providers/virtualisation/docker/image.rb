module Providers
  class Docker < ::Divisions::Provider
    class Image < ::Divisions::Image

      class << self
        def safety_overrides; { privileged: false } ;end
      end

      def export
        emit.tap { |m| m[:export_path] = "#{identifier}.tar" }
      end

      def commit
        emit.tap { |m| m[:commit] = true }
      end

      def post_processor_stanzas
        {
          type: "#{type}-tag",
          repository: image,
          tags: 'latest'
        }
      end

    end
  end
end
