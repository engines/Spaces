module Arenas
  module Commands
    class Saving < ::Spaces::Commands::Saving

      def assemble
        @model ||= super.associated
      end

    end
  end
end
