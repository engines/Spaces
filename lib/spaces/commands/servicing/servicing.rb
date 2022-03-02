module Servicing
  module Commands
    class Servicing < ::Spaces::Commands::Reading

      def milestone
        input[:milestone]
      end

      def consumer_identifier
        input[:consumer_identifier]
      end

      def assembly
        model.as_service_for(consumer)
      end

      def consumer
        space.by(consumer_identifier).as_consumer
      end

      protected

      def commit
        assembly.execute_for(milestone) || []
      end

    end
  end
end
