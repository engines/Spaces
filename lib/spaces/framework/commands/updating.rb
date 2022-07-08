require_relative 'saving'

module Spaces
  module Commands
    class Updating < Saving

      def model_struct = current_model.struct.merge(super)

    end
  end
end
