require_relative 'reading'

module Spaces
  module Commands
    class Graphing < Reading

      protected

      def assembly
        space.graph(identifier, **input)
      end

    end
  end
end
