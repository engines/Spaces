module Commissioning
  module Commands
    class Executing < ::Spaces::Commands::Executing

      def assembly = model.as_commission

      protected

      def commit
        assembly.tap do |a|
          a.execute(instruction)
        end.state
      end

    end
  end
end
