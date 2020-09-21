require_relative '../../emitting/emissions/stanza'

module Dns
  module Stanzas
    class Provider < ::Emitting::Stanza

      def declaratives
        q
      end

    end
  end
end
