require_relative '../../spaces/model'

module Docker
  module Files
    class Step < ::Spaces::Model

      relation_accessor :context
      attr_reader :product

      def home_app_path
        context.home_app_path
      end

      def initialize(context)
        self.context = context
      end

    end
  end
end
