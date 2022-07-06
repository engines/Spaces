module Arenas
  module Commands
    class Staging < ::Spaces::Commands::Iterating

      def mutating?; true ;end

      def subcommands
        @subcommands ||= [
          Resolving.new(**subcommand_inputs),
          Packing.new(**subcommand_inputs),
          Orchestrating.new(**subcommand_inputs)
        ]
      end

      def subcommand_inputs
        @subcommand_inputs ||= {identifier: identifier, space: space_identifier}
      end

    end
  end
end
