module Packing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :packs ;end

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          update: Commands::Saving,
          artifacts: [::Spaces::Commands::Artifacts, {space: :packs}],
          build: [Commands::Building, {background: true}]
        })
      end

    end
  end
end
