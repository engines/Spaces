require_relative '../../emitting/emissions/stanza'

module Provisioning
  module Stanzas
    class Dns < ::Emitting::Stanza

      def declaratives
        context.dns_default.stanzas.map(&:declaratives).join("\n")
      end

    end
  end
end
