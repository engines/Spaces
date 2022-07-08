module Servicing
  module Commands
    class Servicing < ::Spaces::Commands::Reading

      def milestone = input_for(:milestone)

      def consumer_identifier = input_for(:consumer_identifier)

      def assembly = model.as_service_for(consumer)

      def consumer = space.by(consumer_identifier).as_consumer

      protected

      def commit
        assembly.execute_for(milestone) || []
      end

    end
  end
end
