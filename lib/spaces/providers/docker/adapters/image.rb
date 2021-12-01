module Adapters
  module Docker
    class Image < ::Adapters::Image

      delegate identifier: :division

      def snippets
        "FROM #{base_image_identifier}"
      end

    end
  end
end
