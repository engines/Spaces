module Arenas
  module Commands
    class Building < ::Spaces::Commands::Iterating

      def array
        @array ||= model.all_packs
      end

      def subcommand_inputs
        {space: :packs}
      end

      def subcommand_class; ::Packing::Commands::Building ;end

    end
  end
end
