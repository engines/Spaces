module Provisioning
  module Stanzas
    class Providers < ::Emissions::Stanza

      def declaratives
        context.providers.map(&:declaratives).join("\n")
      end

    end
  end
end
