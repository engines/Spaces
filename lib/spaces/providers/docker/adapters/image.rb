module Adapters
  module Docker
    class Image < ::Adapters::Image

      delegate identifier: :division

      def snippets = "FROM #{identifier}"

    end
  end
end
