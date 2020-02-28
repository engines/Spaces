require_relative 'requires'

module Environments
  module Steps
    class Ports < Docker::Files::Step

      def content
        [
          worker_ports,
          ports.map { |p| expose(p)}
        ]
      end

      def expose(port)
        "EXPOSE #{port.port}"
      end

      def worker_ports
        "ENV WorkerPorts '#{ports.map(&:port).compact.join(' ')}'"
      end

      def ports
        @ports ||= context.ports || []
      end

    end
  end
end
