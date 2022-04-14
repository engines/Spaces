module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Command

      protected

      def commit
        space.export(**input)
      end

    end
  end
end
