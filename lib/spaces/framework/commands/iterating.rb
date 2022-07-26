require_relative 'modelling'

module Spaces
  module Commands
    class Iterating < Modelling

      alias_method :model, :current_model

      def result =  payload.map(&:result)
      def errors = payload.map(&:errors)

      def payload = subcommands.map(&:payload)

      def subcommands
        @subcommands ||= inputs.map do |i|
          subcommand_class.new(i)
        end
      end

      def inputs
        @inputs ||= array.map do |i|
          subcommand_inputs.merge(identifier: i.identifier)
        end
      end

      def array = []

      def subcommand_class = nil
      def subcommand_inputs =  {}

      def mutating? = subcommand_class.mutating?

      protected

      def _run
        struct.result = subcommands.map(&:run).map(&:result)
      end

    end
  end
end
