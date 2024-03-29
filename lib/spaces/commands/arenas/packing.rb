module Arenas
  module Commands
    class Packing < ::Spaces::Commands::Iterating

      def array
        @array ||= model.packables
      end

      def subcommand_inputs = {space: :packs}

      def subcommand_class = ::Packing::Commands::Saving

    end
  end
end
