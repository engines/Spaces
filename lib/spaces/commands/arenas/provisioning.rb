module Arenas
  module Commands
    class Provisioning < ::Spaces::Commands::Iterating

      def array
        @array ||= model.provisionables
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Provisioning::Commands::Saving ;end

    end
  end
end
