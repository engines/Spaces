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

      def packing_stanzas
        matching_images.map do |i|
          {
            type: "#{i.type}-tag",
            repository: i.image,
            tags: 'latest'
          }
        end
      end

      def matching_images
        emission.images.all.select { |i| matching_types.include?(i.type) }
      end

      def matching_types
        [:docker]
      end

    end
  end
end
