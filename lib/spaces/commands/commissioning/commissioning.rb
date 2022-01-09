module Commissioning
  module Commands
    class Commissioning < ::Spaces::Commands::Iterating

      def milestone
        input[:milestone]
      end

      def assembly
        model.as_consumer
      end

      def array
       @array ||= assembly.service_identifiers_for(milestone)
      end

      def inputs
        @inputs ||= array.map do |i|
          {
            identifier: i,
            consumer_identifier: identifier,
            milestone: milestone,
            space: space_identifier
          }
        end
      end

      def subcommand_class; ::Servicing::Commands::Servicing ;end

      protected

      def commit
        assembly.execute_for(milestone)
      end

    end
  end
end
