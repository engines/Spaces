module Packing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :packs ;end

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          update: Commands::Saving,
          commit: [Commands::Executing, execute: :commit],
          artifacts: Commands::Artifacts
        })
      end

    end
  end
end
