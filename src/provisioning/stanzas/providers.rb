require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Providers < ::Releases::Stanza

      def declaratives
        context.providers.map(&:declaratives).join("\n")
      end

    end
  end
end
