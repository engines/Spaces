require_relative 'saving'

module Spaces
  module Commands
    class Copying < Saving

      alias_method :model, :current_model

      def assembly = model.tap { model.identifier = new_identifier }

      def new_identifier =
        (input[:new_identifier] || [identifier,'_copy'].join).to_s

      protected

      def commit
        space.save(assembly)
      end

    end
  end
end
