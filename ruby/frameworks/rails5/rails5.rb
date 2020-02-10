require_relative '../framework'

module Frameworks
  module Rails5
    class Rails5 < Framework

      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'rails5'
        end

        def step_precedence
          @@rails5_step_precedence ||= {
            first: [:from_image],
            anywhere: [:variables],
            last:  [:bundle, :rake_tasks]
          }
        end
      end

      def default_port
        3000
      end

    end
  end
end
