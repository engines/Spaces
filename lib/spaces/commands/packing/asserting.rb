module Packing
  module Commands
    module Asserting

      def precondition
        {
          runtime_exists: model.perform?(:runtime),
          packing_exists: model.perform?(:packing)
        }
      end

    end
  end
end
