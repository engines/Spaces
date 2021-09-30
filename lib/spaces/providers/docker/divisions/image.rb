module Providers
  module Docker
    class Image < ::ProviderAspects::Image

      delegate name: :division

      def packing_stanza
        "FROM #{name}"
      end

    end
  end
end
