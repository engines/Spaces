module Providers
  module Docker
    class Execution < ::Adapters::Execution #TODO: decide if we need empty classes

      def snippets
        "CMD #{division.struct[:CMD]}"
      end

    end
  end
end
