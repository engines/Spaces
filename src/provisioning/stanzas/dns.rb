require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Dns < ::Releases::Stanza

      def declaratives
        context.dns_default.stanzas.map(&:declaratives).join("\n")
      end

    end
  end
end
