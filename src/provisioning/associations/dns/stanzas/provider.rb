require_relative '../../../../emitting/emissions/stanza'

module Dns
  module Stanzas
    class Provider < ::Emissions::Stanza

      def declaratives
        q
      end

    end
  end
end
