module Blueprinting
  module Commands
    class Relations < Spaces::Commands::Reading

      def assembly
        super.relations
      end

    end
  end
end
