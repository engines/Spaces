require_relative 'inputs'

module Spaces
  module Commands
    class Command < ::Spaces::Model
      include Inputs

      class << self
        def mutating? = itself <= Saving
        def interfacing? = itself <= Executing
      end

      delegate(
        commands: :universe,
        [:mutating?, :interfacing?] => :klass
      )

      def result = struct[:result]
      def errors = struct[:errors]
      def payload = OpenStruct.new(struct.to_h.without(:input))

      def run
        tap do
          insist
          struct.result = _run
        rescue ::Spaces::Errors::SpacesError => e
          struct.errors = e.diagnostics
        end
      end

      def log
        tap do
          commands.save(self) if mutating? || interfacing?
        end
      end

      def has_run? = !payload.empty?
      def success? = has_run? && errors.nil?
      def fail? = has_run? && !success?

      def space = universe.send(space_identifier)

      def file_name = stamp_elements.join('_')

      def stamp_elements =
        [
          "#{Time.now.to_i}",
          qualifier,
          context_identifier
        ]

      def initialize(input)
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

      def assembly = nil
      def commit = nil

    end
  end
end
