require_relative 'controller'

module Spaces
  module Controllers
    class RESTController < Controller

      def action_command_map
        @action_command_map ||= {
          index: [Commands::Querying, method: :summaries],
          list: [Commands::Querying, method: :identifiers],
          all: [Commands::Querying, method: :all],
          summarize: Commands::Summarizing,
          show: Commands::Reading,
          create: Commands::Saving,
          update: Commands::Saving,
          copy: Commands::Copying,
          delete: Commands::Deleting
        }
      end

    end
  end
end
