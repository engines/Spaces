module Publishing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :publications ;end

      def action_command_map
        @action_command_map ||= super.merge({
          import: [Commands::Importing, threaded: true],
          export: [Commands::Exporting, threaded: true],
          synchronize: Commands::Synchronizing
        })
      end

    end
  end
end
