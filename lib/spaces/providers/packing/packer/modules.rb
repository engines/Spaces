module Providers
  class Packer < ::ProviderAspects::Provider
    class Modules < ::ProviderAspects::Modules

      def packing_artifact_for(language)
        {
          type: 'shell',
          inline: division.send(language).inline
        }
      end

    end
  end
end
