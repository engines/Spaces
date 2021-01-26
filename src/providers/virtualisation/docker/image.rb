module Providers
  class Docker < ::Divisions::Provider
    class Image < ::Divisions::Image
      class << self
        def safety_overrides
          { privileged: false }
        end
      end

      def default_name
        "#{tenant.identifier}/#{context_identifier}"
      end

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
          tags: 'latest'
        }
      end
    end
  end
end
