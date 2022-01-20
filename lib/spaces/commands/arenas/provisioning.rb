module Arenas
  module Commands
    class Provisioning < ::Spaces::Commands::Reading

      def space_identifier
        super || :arenas
      end

      protected

      def _run
        struct.result = space.save_artifacts_for(model, :provisioning).map(&:content)
      end

    end
  end
end
