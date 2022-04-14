module Arenas
  module Commands
    class Staging < ::Spaces::Commands::Iterating

      def blueprint_identifier
        input_for(:blueprint_identifier)
      end

      def mutating?; true ;end

      def subcommands
        @subcommands ||= [
          Binding.new(subcommand_input.merge(blueprint_identifier: blueprint_identifier)),
          Resolving.new(subcommand_input),
          Packing.new(subcommand_input),
          Orchestrating.new(subcommand_input)
        ]
      end

      def subcommand_input
        @subcommandinput ||= {identifier: identifier, space: space_identifier}
      end

    end
  end
end
