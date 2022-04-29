require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading
      include ::Streaming::Streaming

      protected

      def commit
        space.execute(input_for(:execute), model, stream: stream)
      end

    end
  end
end
