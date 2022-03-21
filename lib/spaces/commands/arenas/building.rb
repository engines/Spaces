module Arenas
  module Commands
    class Building < ::Spaces::Commands::Iterating

      def array
        @array ||= model.all_packs
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Imaging::Commands::Building ;end

    end
  end
end
