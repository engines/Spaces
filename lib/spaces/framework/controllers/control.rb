module Spaces
  module Controllers
    class Control < ::Spaces::Model

      alias_method :signature, :struct

      def attempt
        arguments[:background] ? _attempt_with_threading : _attempt
      end

      def command
        @command ||= signature.klass.new(**arguments)
      end

      def arguments
        signature.arguments || {}
      end

      def calling_chain; [:run, :payload] ;end

      def initialize(signature)
        self.struct = signature
      end

      protected

      def _attempt_with_threading
        self.struct.arguments[:timestamp] = "#{Time.now.to_i}"
        {result: arguments.tap { Thread.new { _attempt } }}
      end

      def _attempt(with: calling_chain)
        with.reduce(command) { |c, w| c.send(w) }
      end

    end
  end
end
