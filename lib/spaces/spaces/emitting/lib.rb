module Spaces
  module Emitting
    module Lib
      def output_callback
        ->(output) { yield output if block_given? }
      end

      def color
        Emitting::Color
      end

      def emit_to(*args, &block)
        Emitting::Output.emit_to(*args, &block)
      end
    end
  end
end
