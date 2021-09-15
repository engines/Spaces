module Spaces
  module Controllers
    class Control < ::Spaces::Model

      attr_accessor :block

      alias_method :signature, :struct

      def attempt
        log
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
        Thread.new { _attempt }
      end

      def _attempt(with: calling_chain)
        with.reduce(command) { |c, w| c.send(w, &block) }
      end

      def log
        logger.info("Controller command: #{arguments} #{block&.call || 'Block not given'}")
      end

    end
  end
end
