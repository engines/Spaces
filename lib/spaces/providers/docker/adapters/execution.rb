module Adapters
  module Docker
    class Execution < ::Adapters::Execution

      def snippets_for(precedence) = 'CMD /usr/local/bin/start.sh'

    end
  end
end
