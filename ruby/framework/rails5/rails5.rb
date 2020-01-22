require_relative '../framework'

module Framework
    class Rails5 < Framework

      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'rails5'
        end

        def step_precedence
          @@rails5_step_precedence ||= {
            first: [:from_image],
            anywhere: [:variables, :adds],
            last:  [:bundle, :rake_tasks]
          }
        end
      end

    end
end
