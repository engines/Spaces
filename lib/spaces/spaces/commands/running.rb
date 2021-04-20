module Spaces
  module Commands
    class Running < ::Spaces::Model

      def run
        tap { _result }
      end

      def space
        universe.send(space_name)
      end

      def space_name
        input[:space]
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

      protected

      def _result
        struct.result =
        if c = commit
          c
        else
          assembly
        end
      end

      def assembly ;end
      def commit ;end

    end
  end
end
