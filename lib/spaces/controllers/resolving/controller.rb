module Resolving
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :resolutions ;end

      def action_command_map
        @action_command_map ||= super.merge({
          default: Commands::Default
        })
      end

    end
  end
end
