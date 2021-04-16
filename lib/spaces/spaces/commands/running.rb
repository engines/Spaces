module Spaces
  module Commands
    class Running < ::Spaces::Model

      def run
        tap {
          assemble
          commit
        }
      end

      def assemble ;end
      def commit ;end

      def space
        universe.send(space_name)
      end

      def space_name
        input[:space] || klass.name.split('::').first.underscore
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

    end
  end
end
