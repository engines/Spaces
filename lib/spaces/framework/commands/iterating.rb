require_relative 'modelling'

module Spaces
  module Commands
    class Iterating < Modelling

      alias_method :model, :current_model

      def result; payload.map(&:result) ;end
      def errors; payload.map(&:errors) ;end

      def payload; subcommands.map(&:payload) ;end

      def subcommands
        @subcommands ||= inputs.map do |i|
          subcommand_class.new(i)
        end
      end

      def inputs
        @inputs ||= array.map do |i|
          {identifier: i.identifier}
        end
      end

      def array; [] ;end

      def subcommand_class ;end

      protected

      def _run
        space.touch(model) if subcommand_class.mutating?
        subcommands.each(&:run)
      end

    end
  end
end
