require_relative 'modelling'

module Spaces
  module Commands
    class Deleting < Modelling

      def commit
        struct.result = (space.delete(identifier) if space.exist?(identifier))
      end

    end
  end
end
