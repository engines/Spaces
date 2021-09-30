module Providers
  module Packer
    class Modules < ::ProviderAspects::Modules

      def packing_stanza_for(language)
        {
          type: 'shell',
          inline: division.send(language).inline
        }
      end

    end
  end
end
