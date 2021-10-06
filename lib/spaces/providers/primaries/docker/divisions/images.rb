module Providers
  module Docker
    class Images < ::ProviderAspects::Images

      def packing_stanza
        super.join("\n")
      end

    end
  end
end
