require_relative 'controller'

module Spaces
  module Controllers
    class Querying < Controller

      def action_command_map
        @action_command_map ||= {
          list: Commands::Querying
        }
      end

    end
  end
end
