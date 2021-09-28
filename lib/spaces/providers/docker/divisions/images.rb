module Providers
  module Docker
    class Images < ::ProviderAspects::Images

      def packing_artifact
        super.join("\n")
      end

    end
  end
end
