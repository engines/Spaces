require_relative 'controller'

module Blueprinting
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def initialize(**args)
        self.struct = OpenStruct.new({space: :blueprints}.merge(args.symbolize_keys))
      end

    end
  end
end
