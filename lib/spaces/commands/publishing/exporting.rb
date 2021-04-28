module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Running

      def identifier
        input[:identifier]&.to_s
      end

      def message
        input[:message]&.to_s
      end

      def space_identifier
        super || :publications
      end

      protected

      def commit
        space.export(identifier, message: message)
      end

    end
  end
end
