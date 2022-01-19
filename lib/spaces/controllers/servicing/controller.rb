module Servicing
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier; :resolutions ;end

      def action_command_map
        @action_command_map ||= {
          service: Commands::Servicing
        }
      end

    end
  end
end
