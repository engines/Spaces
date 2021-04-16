require_relative 'modelling'

module Spaces
  module Commands
    class Saving < Modelling

      alias_method :model, :fresh_model

      def commit
        struct.result = space.save(model)
      end

    end
  end
end
