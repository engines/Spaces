require_relative 'reading'

module Spaces
  module Commands
    class Summarizing < Reading

      def assembly
        super.summary
      rescue NoMethodError
        raise ::Spaces::Errors::CommandFail, {method_missing: :summary, input: input}
      end

    end
  end
end
