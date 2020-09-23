module Provisioning
  module Stanzas
    class Dns < ::Emissions::Stanza

      def declaratives
        context.dns_default.stanzas.map(&:declaratives).join("\n")
      end

    end
  end
end
