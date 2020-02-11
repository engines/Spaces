require_relative '../framework'

module Frameworks
  module ApachePHP
    class ApachePHP < Framework

      Dir["#{__dir__}/scripts/*"].each { |f| require f }
      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'apache_php'
        end

        def script_precedence
          @@apache_php_script_precedence ||= [:configuration, :installation, :completion]
        end

        def step_precedence
          @@apache_php_step_precedence ||= {
            first: [:from_image],
            anywhere: [:variables],
            last: [:configure]
          }
        end
      end

      def default_port
        8000
      end

    end
  end
end
