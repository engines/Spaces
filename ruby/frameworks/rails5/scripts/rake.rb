require_relative '../../../collaborators/script_once'

module Frameworks
  module Rails5
    module Scripts
      class Rake < Collaborators::ScriptOnce

        def body
          "bundle exec rake $*"
        end

      end
    end
  end
end
