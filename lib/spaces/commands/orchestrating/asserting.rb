module Orchestrating
  module Commands
    module Asserting

      def precondition
        {
          runtime_exists: model.perform?(:runtime),
          orchestration_exists: model.perform?(:orchestration)
        }
      end

    end
  end
end
