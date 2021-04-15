module Spaces
  module Commands
    class Reading < ::Spaces::Model

      def identifier
        input[:identifier]
      end

      def run
        tap do
          assemble
          commit
        end
      end

      def model
        @model ||= if space.exist?(identifier)
          space.by(identifier)
        end
      end

      alias_method :assemble, :model

      def commit
        struct.result = model
      end

      def model_class
        space.default_model_class
      end

      def space
        universe.send(space_name)
      end

      def space_name
        input[:space] || klass.name.split('::').first.underscore.singularize
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

    end
  end
end
