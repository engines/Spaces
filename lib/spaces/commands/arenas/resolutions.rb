module Arenas
  module Commands
    class Resolutions < ::Spaces::Commands::Reading

      def assembly
        model.bound_resolutions
      end

      def space_identifier
        super || :arenas
      end

    end
  end
end
