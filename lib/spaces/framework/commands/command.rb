require_relative 'inputs'

module Spaces
  module Commands
    class Command < ::Spaces::Model
      include Inputs

      class << self
        def mutating?; itself <= Saving ;end
      end

      def result; struct[:result] ;end
      def errors; struct[:errors] ;end
      def payload; OpenStruct.new(struct.to_h.without(:input)) ;end

      def run
        tap do
          insist
          struct.result = _run
        rescue ::Spaces::Errors::SpacesError => e
          struct.errors = e.diagnostics
          # TODO:
          # Handling of errors when action is :threaded or :streaming.
          # struct.errors won't be logged or returned to client in these cases
        end
      end

      def has_run?; !payload.empty? ;end
      def success?; has_run? && errors.nil? ;end
      def fail?; has_run? && !success? ;end

      def space
        universe.send(space_identifier)
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys.clean)
      end

      protected

      def _run
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
