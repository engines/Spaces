module Spaces
  module Outputting
    class Space < Spaces::Space

      def method_missing(m, input, &block)
        read(m, input, &block)
      end

      private

      def read(command, input, &block)
        Spaces::Outputting.const_get(command.camelize)
        .new(command: self, identifier: input[:identifier])
        .read(&block)
      end

    end
  end
end
