module Commissioning
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier; :resolutions ;end

      def action_command_map
        @action_command_map ||= {
          commission: Commands::Commissioning,
          start: [Commands::Executing, {execute: :start}]
        }
      end

    end
  end
end
