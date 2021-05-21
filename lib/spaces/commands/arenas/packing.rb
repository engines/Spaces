module Arenas
  module Commands
    class Packing < ::Spaces::Commands::Iterating

      def array
        @array ||= model.packables
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Packing::Commands::Saving ;end

    end
  end
end
