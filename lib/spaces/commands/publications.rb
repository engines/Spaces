module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving

      def assemble
        @model ||= super.deflated
      end

      def commit
        struct.result = space.import(model, force: force)
      end

      def force
        input[:force] || false
      end

      def space
        universe.publications
      end

      def model_class
        Spaces::Descriptor
      end
    end
  end
end
