module Spaces
  module Controllers
    class Control < ::Spaces::Model

      alias_method :signature, :struct

      def attempt
        arguments[:threaded] ? _attempt_with_threading : _attempt
      end

      def command
        @command ||= signature.klass.new(**arguments)
      end

      def arguments = signature.arguments || {}

      def calling_chain = [:run, :payload]

      def initialize(signature)
        self.struct = signature
      end

      protected

      def _attempt_with_threading
        {result: arguments.tap { Thread.new { _attempt } }}
      end

      def _attempt(with: calling_chain)
        with.reduce(command) { |c, w| c.send(w) }
      end

    end
  end
end
