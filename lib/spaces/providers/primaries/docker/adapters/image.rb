module Providers
  module Docker
    class Image < ::Adapters::Image

      delegate name: :division

      def snippets
        "FROM #{name}"
      end

    end
  end
end
