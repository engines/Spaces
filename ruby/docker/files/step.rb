require_relative '../../spaces/model'

module Docker
  module Files
    class Step < ::Spaces::Model

      relation_accessor :context

      delegate([:instructions, :home_app_path] =>  :context)

      def initialize(context)
        self.context = context
      end

    end
  end
end
