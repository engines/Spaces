module Blueprinting
  module Commands
    class Relations < Spaces::Commands::Reading

      def assembly
        super.relations
      end

      def space_identifier
        super || :blueprints
      end

    end
  end
end
