require_relative 'modelling'

module Spaces
  module Commands
    class Deleting < Modelling

      protected

      def commit
        space.delete(identifier)
      end

    end
  end
end
