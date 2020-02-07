require_relative '../../steps/variables'

module Frameworks
  class ApachePHP
    class Variables < Framework::Variables

      def content
      [
        super,
        %Q(
        ENV ContUser www-data
        )
      ]
      end

    end
  end
end
