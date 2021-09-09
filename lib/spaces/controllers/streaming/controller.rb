module Streaming
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :streaming ;end

      def action_command_map
        @action_command_map ||= super.merge({
          import: Commands::ImportOut,
          export: Commands::ExportOut,
          build: Commands::BuildOut
        })
      end

    end
  end
end
