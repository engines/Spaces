module Providers
  module Packer
    class ManagedPackages < ::Adapters::ManagedPackages

      def snippets_for(language) =
        {
          type: 'shell',
          inline: division.send(language).inline
        }

    end
  end
end
