require_relative 'controller'

module Spaces
  module Controllers
    class RESTController < Controller

      def method_class_map
        @method_class_map ||= {
          index: [Commands::Querying, method: :summaries],
          list: [Commands::Querying, method: :identifiers],
          summary: Commands::Summarizing,
          show: Commands::Reading,
          new: Commands::Saving,
          update: Commands::Saving,
          delete: Commands::Deleting
        }
      end

      def initialize(**args)
        self.struct = OpenStruct.new({space: space_identifier}.merge(args.symbolize_keys))
      end

    end
  end
end
