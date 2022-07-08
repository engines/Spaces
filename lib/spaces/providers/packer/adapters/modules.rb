module Providers
  module Packer
    class Modules < ::Adapters::Modules

      def snippets_for(language) =
        {
          type: 'shell',
          inline: division.send(language).inline
        }

    end
  end
end
