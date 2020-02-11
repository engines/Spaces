require_relative '../../spaces/model'

module Docker
  module Files
    class Step < ::Spaces::Model

      relation_accessor :context
      attr_reader :content

      def initialize(context)
        self.context = context
      end

    end
  end
end
