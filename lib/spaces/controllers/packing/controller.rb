module Packing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :packs

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          update: Commands::Saving,
          artifacts: [::Spaces::Commands::Artifacts, {space: :packs}],
          build: Commands::Building
        })
      end

    end
  end
end
