module Divisions
  class Port < ::Divisions::Subdivision

    class << self
      def features; [:start_port, :end_port, :protocol, :external_port] ;end
    end

    def command
      "/usr/local/bin/open_port.sh -h #{address} -p #{protocol} -e #{external_port} -s #{port_range}"
    end

    def address; arena&.configuration&.address ;end

    def port_range; [start_port, end_port].compact.join(':') ;end
    def end_port; struct.end_port ;end

  end
end
