module Spaces
  module Controllers
    class Control < ::Spaces::Model

      attr_accessor :block

      alias_method :signature, :struct

      def attempt
        arguments[:threaded] ? _attempt_with_threading : _attempt
      end

      def command
        @command ||= signature.klass.new(**arguments)
      end

      def arguments
        signature.arguments || {}
      end

      def calling_chain; [:run, :payload] ;end

      def initialize(signature, &block)
        self.struct = signature
        self.block = block
      end

      protected

      def _attempt_with_threading
        Thread.new { _attempt }.join.value
      end

      def _attempt(with: calling_chain)
        with.reduce(command) { |c, w| c.send(w) }
      end

    end
  end
end
