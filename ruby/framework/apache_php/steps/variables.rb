require_relative '../../steps/variables'

module Framework
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
