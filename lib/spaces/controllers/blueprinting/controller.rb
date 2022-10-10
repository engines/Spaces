module Blueprinting
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :blueprints

      def action_command_map
        @action_command_map ||= super.merge({
          bindables: [::Spaces::Commands::Querying, method: :bindables_for],
          relations: Commands::Relations,
          synchronize: Commands::Synchronizing
        })
      end

    end
  end
end
