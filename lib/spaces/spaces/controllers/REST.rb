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
          new: Commands::Saving,
          update: Commands::Saving,
          copy: Commands::Copying,
          delete: Commands::Deleting
        }
      end

      def summary(**args)
        control(command: :summary, **args)
      end

      def initialize(**args)
puts "#{self.class} / Spaces::Controllers::RESTController :initialize ARGS: #{args}"

        self.struct = OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))
      end

    end
  end
end
