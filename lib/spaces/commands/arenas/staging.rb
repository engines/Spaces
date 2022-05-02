module Arenas
  module Commands
    class Staging < ::Spaces::Commands::Iterating

      def blueprint_identifier
        input_for(:blueprint_identifier)
      end

      def mutating?; true ;end

      def subcommands
        @subcommands ||= [
          Binding.new(subcommand_inputs.merge(blueprint_identifier: blueprint_identifier)),
          Resolving.new(subcommand_inputs),
          Packing.new(subcommand_inputs),
          Orchestrating.new(subcommand_inputs)
        ]
      end

      def subcommand_inputs
        @subcommand_inputs ||= {identifier: identifier, space: space_identifier}
      end

    end
  end
end
