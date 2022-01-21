module Installing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :installations ;end

      def action_command_map
        @action_command_map ||= super.merge({
          default: Commands::Default
        })
      end

    end
  end
end
