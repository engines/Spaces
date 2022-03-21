module Imaging
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier; :packs ;end

      def action_command_map
        @action_command_map ||= super.merge({
          build: Commands::Building
        })
      end

    end
  end
end
