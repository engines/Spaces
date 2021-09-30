module Packing
  module Commands
    class Artifact < Spaces::Commands::Reading

      def assembly
        super.artifact
      end

      def space_identifier
        super || :packs
      end

    end
  end
end
