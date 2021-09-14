module Outputting
  module Commands
    class Build < ::Spaces::Commands::Command

      def space_identifier
        super || :outputting
      end

      protected

      def commit(&block)
        space.build(**input, &block)
      end

    end
  end
end
