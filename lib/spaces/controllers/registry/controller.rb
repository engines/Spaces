module Registry
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier; :registry ;end

      def action_command_map
        @action_command_map ||= {
          show: Commands::Reading,
          register: Commands::Registering
        }
      end

    end
  end
end
