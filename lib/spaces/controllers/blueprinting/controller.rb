module Blueprinting
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :blueprints ;end

      def action_command_map
        @action_command_map ||= super.merge({
          relations: ::Blueprinting::Commands::Relations
        })
      end

    end
  end
end
