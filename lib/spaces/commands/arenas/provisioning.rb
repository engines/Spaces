module Arenas
  module Commands
    class Provisioning < ::Spaces::Commands::Iterating

      def array
        @array ||= model.bound_resolutions # NOW WHAT?
      end

      def space_identifier
        super || :arenas
      end

      def subcommand_class; ::Provisioning::Commands::Saving ;end

      protected

      def _run
        [space.save_provisioning_artifacts_for(model), super].flatten
      end

    end
  end
end
