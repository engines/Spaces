module Commissioning
  module Commands
    class Executing < ::Spaces::Commands::Executing

      def assembly
        model.as_commission
      end

      protected

      def commit
        assembly.tap do |a|
          a.execute(execution_instruction)
        end.state
      end

    end
  end
end
