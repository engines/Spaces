module Publishing
  module Commands
    class Importing < ::Spaces::Commands::Saving

      alias_method :descriptor, :model

      def assembly
        descriptor.deflated
      end

      def force
        input[:force] || false
      end

      def space_name
        super || :publications
      end

      def model_class
        Spaces::Descriptor
      end

      protected

      def commit
        space.import(descriptor, force: force)
      end

    end
  end
end
