require_relative '../web_server'

module WebServers
  module Passenger
    class Passenger < WebServer

      class << self
        def identifier
          'passenger'
        end
      end

    end
  end
end
