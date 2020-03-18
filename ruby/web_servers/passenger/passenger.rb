require_relative '../web_server'

module WebServers
  module Passenger
    class Passenger < WebServer

      class << self
        def identifier
          'passenger'
        end

        def step_precedence
          @@passenger_step_precedence ||= {}
        end

        def script_lot
          @@passenger_script_lot ||= []
        end
      end

    end
  end
end
