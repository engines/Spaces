module Images
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier; :images ;end

      def action_command_map
        @action_command_map ||= super.merge({
        })
      end

    end
  end
end
