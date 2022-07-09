module Publishing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :publications

      def action_command_map
        @action_command_map ||= super.merge({
          identify: Commands::Identifying,
          import: [Commands::Importing, background: true],
          export: [Commands::Exporting, background: true],
          synchronize: Commands::Synchronizing
        })
      end

    end
  end
end
