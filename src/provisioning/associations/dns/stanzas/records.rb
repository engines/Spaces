require_relative '../../../../emitting/emissions/stanza'

module Dns
  module Stanzas
    class Records < ::Emissions::Stanza

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
