module Outputting
  module Commands
    class Export < ::Spaces::Commands::Command

      def space_identifier
        super || :outputting
      end

      protected

      def commit(&block)
        space.export(**input, &block)
      end

    end
  end
end
