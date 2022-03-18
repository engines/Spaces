require_relative 'streaming'

module Providers
  module Docker
    class Interface < ::Providers::Interface
      extend ::Docker
      include Streaming

      ::Docker.options[:read_timeout] = 1000
      ::Docker.options[:write_timeout] = 1000

      def get(id)
        model_class.new(self, bridge.get(id))
      end

      alias_method :by, :get

      def all(options = {})
        @all ||= bridge.all(options.reverse_merge(all: true)).map { |i| summary_class.new(self, i) }
      end

      def process_output(encoded)
        # FIX ME! The commented-out code causes JSON parse errors while building an image
        # output = JSON.parse(encoded, symbolize_names: true)
        # stream.error("#{output[:error]}\n") if output[:error]
        # stream.output(output[:stream]) if output[:stream]
        stream.output(encoded)
      end

      def summary_class; model_class ;end

    end
  end
end
