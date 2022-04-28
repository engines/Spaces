module Spaces
  module Commands
    class Command < ::Spaces::Model

      class << self
        def mutating?; itself <= Saving ;end
      end

      def result; struct[:result] ;end
      def errors; struct[:errors] ;end
      def payload; OpenStruct.new(struct.to_h.without(:input)) ;end

      def run
        tap do
          _run
        rescue ::Spaces::Errors::SpacesError => e
          # TODO:
          # Handling of errors when action is :threaded or :streaming.
          # struct.errors won't be logged or returned to client in these cases
          struct.errors = e.diagnostics
        end
      end

      def has_run?; !payload.empty? ;end
      def success?; has_run? && errors.nil? ;end
      def fail?; has_run? && !success? ;end

      def space
        universe.send(space_identifier)
      end

      def space_identifier(default: nil)
        input_for(:space, default: default)
      end

      def input_for(key, mandatory: true, default: nil, klass: String)
        typed_input_value_for(input[key].nil? ? default : input[key], klass).tap do |value|
          raise ::Spaces::Errors::MissingInput, {input: input} if value.nil? && mandatory
        end
      end

      def typed_input_value_for(value, klass)
        return input_value_truthy?(value) if klass == [TrueClass, FalseClass]
        return value.to_s if value && klass == String
        raise ::Spaces::Errors::IncorrectInputType unless [klass].flatten.include?(value.class)
        value
      end

      def input_value_truthy?(value)
        value == true ||
        value.is_a?(String) && !value.blank? ||
        false
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

      protected

      def _run
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
