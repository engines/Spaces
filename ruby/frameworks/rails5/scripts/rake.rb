require_relative '../../../texts/one_time_script'

module Frameworks
  module Rails5
    module Scripts
      class Rake < Texts::OneTimeScript

        def body
          "bundle exec rake $*"
        end

      end
    end
  end
end
