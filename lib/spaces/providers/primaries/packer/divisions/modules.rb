module Providers
  module Packer
    class Modules < ::Adapters::Modules

      def packing_stanza_for(language)
        {
          type: 'shell',
          inline: division.send(language).inline
        }
      end

    end
  end
end
