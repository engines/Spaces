require_relative '../../emitting/stanza'

module Provisioning
  module Stanzas
    class Providers < ::Emitting::Stanza

      def declaratives
        context.providers.map(&:declaratives).join("\n")
      end

    end
  end
end
