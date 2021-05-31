module Providers
  class Packer < ::Providers::Provider
    class Modules < ::Providers::Modules

      def packing_artifact_for(language)
        {
          type: 'shell',
          inline: division.send(language).inline
        }
      end

    end
  end
end
