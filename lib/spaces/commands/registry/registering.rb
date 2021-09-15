module Registry
  module Commands
    class Registering < ::Spaces::Commands::Reading

      def space_identifier; :resolutions ;end

      protected

      def commit
        universe.registry.ensure_entered(model)
      end

    end
  end
end
