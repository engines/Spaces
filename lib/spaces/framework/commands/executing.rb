require_relative 'reading'

module Spaces
  module Commands
    class Executing < Reading
      include ::Streaming::Streaming

      def instruction = input_for(:execute)

      def qualifier = instruction

      protected

      def commit
        with_streaming do
          space.execute(model, instruction: instruction, stream: stream)
        end
      end

    end
  end
end
