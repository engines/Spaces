require_relative '../../../texts/script_once'

module Frameworks
  module Rails5
    module Scripts
      class Rake < Texts::ScriptOnce

        def body
          "bundle exec rake $*"
        end

      end
    end
  end
end
