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

      def input_for(key, mandatory: true, default: nil)
        input[key]&.to_s || default ||
          (mandatory && (raise ::Spaces::Errors::MissingInput, {input: input}))
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
