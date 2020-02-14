require_relative '../../spaces/model'

module Docker
  module Files
    class Step < ::Spaces::Model

      relation_accessor :context
      attr_reader :content

      def home_app_path
        context.tensor.image_subject.home_app_path
      end

      def initialize(context)
        self.context = context
      end

    end
  end
end
