module Arenas
  module Commands
    class Staging < ::Spaces::Commands::Iterating

      def blueprint_identifier
        input[:blueprint_identifier]&.to_s
      end

      def mutating?; true ;end

      def subcommands
        @subcommands ||= [
          Binding.new(identifier: identifier, blueprint_identifier: blueprint_identifier),
          Resolving.new(identifier: identifier),
          Packing.new(identifier: identifier),
          Provisioning.new(identifier: identifier)
        ]
      end

    end
  end
end
