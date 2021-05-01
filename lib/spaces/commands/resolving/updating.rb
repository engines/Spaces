module Resolving
  module Commands
    class Updating < ::Spaces::Commands::Saving

      def space_identifier
        super || :resolutions
      end

      protected

      def commit
        space.update(model)
      end

    end
  end
end
