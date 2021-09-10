require_relative 'saving'

module Spaces
  module Commands
    class Creating < Saving

      protected

      def commit
        unless space.exist?(model)
          space.save(model)
        else
          raise ::Spaces::Errors::ExistsInSpace, {space: space.identifier, identifier: model.identifier}
        end
      end

    end
  end
end
