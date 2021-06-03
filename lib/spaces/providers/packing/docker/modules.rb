module Providers
  class Docker < ::ProviderAspects::Provider
    class Modules < ::ProviderAspects::Modules

      def packing_artifact_for(language)
        division.send(language).inline.join(connector)
      end

      def connector; "\n" ;end

    end
  end
end
