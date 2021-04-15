require_relative 'reading'

module Spaces
  module Commands
    class Querying < ::Spaces::Commands::Reading

      def assemble
        struct.result ||= space.send(input[:method])
      end

    end
  end
end
