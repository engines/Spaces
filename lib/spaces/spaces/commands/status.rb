require_relative 'reading'

module Spaces
  module Commands
    class Status < Reading

      def assembly
        super.status
      end

    end
  end
end
