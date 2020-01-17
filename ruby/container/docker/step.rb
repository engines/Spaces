require_relative '../../spaces/model'

module Container
  module Docker
    class Step < ::Spaces::Model

      relation_accessor :context
      attr_reader :content

      def initialize(context)
        self.context = context
      end

    end
  end
end
