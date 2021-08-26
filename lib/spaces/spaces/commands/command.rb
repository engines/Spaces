module Spaces
  module Commands
    class Command < ::Spaces::Model

      class << self
        def mutating?; itself <= Saving ;end
      end

      def result; struct[:result] ;end
      def errors; struct[:errors] ;end
      def payload; OpenStruct.new(struct.to_h.without(:input)) ;end


      def run(&block)
        tap do
          _run(&block)
        rescue ::Spaces::Errors::SpacesError => e
          struct.errors = e.diagnostics
        # rescue NoMethodError => e
        #   struct.errors = e.inspect
        end
      end

      def has_run?; !payload.empty? ;end
      def success?; has_run? && errors.nil? ;end
      def fail?; has_run? && !success? ;end

      def space
        universe.send(space_identifier)
      rescue TypeError
        raise ::Spaces::Errors::MissingInput, {input: input}
      end

      def space_identifier
        input[:space]
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

      protected

      def _run(&block)
        struct.result =
        if c = commit(&block)
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
