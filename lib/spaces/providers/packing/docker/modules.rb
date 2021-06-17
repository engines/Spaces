module Providers
  class Docker < ::ProviderAspects::Provider
    class Modules < ::ProviderAspects::Modules

      def packing_artifact_for(language)
        "RUN #{division.send(language).inline.join(connector)}"
      end

      def connector; ' && ' ;end

    end
  end
end
