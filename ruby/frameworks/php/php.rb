require_relative '../framework'

module Frameworks
  module PHP
    class PHP < Framework

      Dir["#{__dir__}/scripts/*"].each { |f| require f }
      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'php'
        end

        def step_precedence
          @@php_step_precedence ||= {
            first: [:from_image],
            anywhere: [:variables]
          }
        end
      end

    end
  end
end
