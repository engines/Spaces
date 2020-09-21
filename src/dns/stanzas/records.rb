require_relative '../../emitting/stanza'

module Dns
  module Stanzas
    class Records < ::Emitting::Stanza

      def declaratives
        Array.new(emission.count) do |i|
          emission.all(:containers).map do |c|
            q(c, i)
          end
        end.join("\n")
      end

    end
  end
end
