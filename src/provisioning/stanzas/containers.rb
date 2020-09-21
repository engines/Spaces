require_relative '../../emitting/emissions/stanza'

module Provisioning
  module Stanzas
    class Containers < ::Emitting::Stanza

      def declaratives
        context.all(:containers).map(&:stanzas).flatten.map(&:declaratives).join("\n")
      end

    end
  end
end
