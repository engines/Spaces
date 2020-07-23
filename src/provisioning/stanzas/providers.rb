require_relative '../stanza'

module Provisioning
  module Stanzas
    class Providers < Stanza

      def declaratives
        divisions.map(&:declaratives).join("\n")
      end

      def divisions
        context.division_map[:provider].uniq(&:uniqueness)
      end

    end
  end
end
