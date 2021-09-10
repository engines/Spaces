module Streaming
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :streaming ;end

      def action_command_map
        @action_command_map ||= super.merge({
          import: Commands::Import,
          export: Commands::Export,
          build: Commands::Build,
          init: Commands::Init,
          plan: Commands::Plan,
          apply: Commands::Apply,
        })
      end

    end
  end
end
