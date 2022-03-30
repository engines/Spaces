module Arenas
  module Commands
    class Provisioning < ::Spaces::Commands::Iterating

      def array
        @array ||= model.directly_bound_resolutions
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Provisioning::Commands::Saving ;end

      protected

      def _run
        space.save_artifacts_for(current_model).map(&:content)
        super
      end

    end
  end
end
