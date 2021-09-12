require_relative 'controller'

module Spaces
  module Controllers
    class RESTController < Controller

      def action_command_map
        @action_command_map ||= {
          index: [Commands::Querying, method: :summaries],
          list: [Commands::Querying, method: :identifiers],
          summary: Commands::Summarizing,
          show: Commands::Reading,
          create: Commands::Saving,
          update: Commands::Saving,
          copy: Commands::Copying,
          delete: Commands::Deleting
        }
      end

      def summary(**args)
        control(command: :summary, **args)
      end

      def initialize(**args)
        self.struct = struct_in_space(**args)
      end

    end
  end
end
