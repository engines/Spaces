require_relative '../../releases/stanza'

module Dns
  module Stanzas
    class Records < ::Releases::Stanza

      def declaratives
        Array.new(collaboration.count) do |i|
          collaboration.all(:containers).map do |c|
            q(collaboration, c, i)
          end
        end.join("\n")
      end

    end
  end
end
