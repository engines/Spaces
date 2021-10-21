require_relative 'controller'

module Spaces
  module Controllers
    class Streaming < Controller

      def action_command_map
        @action_command_map ||= {
          tail: Commands::Tailing
        }
      end

    end
  end
end
