module Keys
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :user_keys ;end

      def action_command_map
        @action_command_map ||= super.merge({
          create: ::Spaces::Commands::Creating,
          update: ::Spaces::Commands::Updating
        })
      end

    end
  end
end
