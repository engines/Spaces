require_relative '../../releases/stanza'

module Dns
  module Stanzas
    class Provider < ::Releases::Stanza

      def declaratives
        q
      end

    end
  end
end
