module Capsules
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :capsules

      def action_command_map
        @action_command_map ||= super.merge({
          execute: ::Spaces::Commands::Executing
        })
      end

    end
  end
end
