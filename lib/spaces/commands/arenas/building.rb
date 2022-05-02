module Arenas
  module Commands
    class Building < ::Spaces::Commands::Iterating
      include ::Streaming::Streaming

      def array
        @array ||= model.all_packs
      end

      def subcommand_inputs
        {space: :packs, stream: stream}
      end

      def subcommand_class; ::Packing::Commands::Building ;end

    end
  end
end
