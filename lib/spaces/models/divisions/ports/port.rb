module Divisions
  class Port < ::Divisions::Subdivision

    class << self
      def features = [:container_port, :end_port, :protocol, :host_port]
    end

    def command =
      "/usr/local/bin/open_port.sh -h #{address} -p #{protocol} -e #{host_port} -s #{port_range}"

    def address = arena&.configuration&.address

    def port_range = [container_port, end_port].compact.join(':')
    def end_port = struct.end_port

  end
end
