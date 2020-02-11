require_relative '../../../products/script'

module Frameworks
  module Rails5
    module Scripts
      class Rake < Products::Script

        def body
          "bundle exec rake $*"
        end

        def identifier
          'rake'
        end

      end
    end
  end
end
