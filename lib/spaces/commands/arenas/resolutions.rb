module Arenas
  module Commands
    class Resolutions < ::Spaces::Commands::Reading

      def assembly
        model.bound_resolutions
      end

    end
  end
end
