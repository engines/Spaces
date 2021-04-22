require_relative 'reading'

module Spaces
  module Commands
    class Status < Reading

      def assembly
        super.status
      rescue NoMethodError
        raise ::Spaces::Errors::CommandFail, {method_missing: :status, input: input}
      end

    end
  end
end
