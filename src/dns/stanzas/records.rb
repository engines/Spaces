require_relative '../../releases/stanza'

module Dns
  module Stanzas
    class Records < ::Releases::Stanza

      def declaratives
        Array.new(release.count) do |i|
          release.all(:containers).map do |c|
            q(c, i)
          end
        end.join("\n")
      end

    end
  end
end
