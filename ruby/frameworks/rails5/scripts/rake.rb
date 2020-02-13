require_relative '../../../products/script_once'

module Frameworks
  module Rails5
    module Scripts
      class Rake < Products::ScriptOnce

        def body
          "bundle exec rake $*"
        end

      end
    end
  end
end
