module Universes
  module Controllers
    class Controller < ::Spaces::Controllers::Controller

      def space_identifier = :universes

      def action_command_map
        @action_command_map ||= {
          show: [::Spaces::Commands::Reading, identifier: :universe],
          create: [::Spaces::Commands::Saving, identifier: :universe],
          update: [::Spaces::Commands::Saving, identifier: :universe]
        }
      end

      def initialize(**args)
        self.struct = struct_in_space(**args)
      end

    end
  end
end
