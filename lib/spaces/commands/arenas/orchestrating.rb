module Arenas
  module Commands
    class Orchestrating < ::Spaces::Commands::Iterating

      def array
        @array ||= model.directly_bound_resolutions
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Orchestrating::Commands::Saving ;end

      protected

      def _run
        space.save_artifacts_for(current_model).map(&:content)
        super
      end

    end
  end
end
