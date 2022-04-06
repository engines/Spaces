module Arenas
  module Commands
    class Saving < ::Spaces::Commands::Saving

      def model
        @model ||= super.associated
      end

    end
  end
end
