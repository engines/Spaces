require_relative '../web_server'

module WebServers
  module Passenger
    class Passenger < WebServer

      # Dir["#{__dir__}/scripts/*"].each { |f| require f }
      # Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'passenger'
        end
      end

    end
  end
end
