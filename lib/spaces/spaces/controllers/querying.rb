require_relative 'controller'

module Spaces
  module Controllers
    class Querying < Controller

      def action_command_map
        @action_command_map ||= {
          list: Commands::Querying
        }
      end

      def initialize(**args)
        self.struct = OpenStruct.new(symbolize_keys)
      end

    end
  end
end
