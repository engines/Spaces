module Provisioning
  module Stanzas
    class Containers < ::Emissions::Stanza

      def declaratives
        context.all(:containers).map(&:stanzas).flatten.map(&:declaratives).join("\n")
      end

    end
  end
end
