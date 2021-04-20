module Packing
  module Commands
    class Artifacts < Spaces::Commands::Reading

      def assembly
        super.artifact
      end

      def space_name
        super || :packs
      end

    end
  end
end
