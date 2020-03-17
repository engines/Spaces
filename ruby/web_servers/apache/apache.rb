require_relative '../web_server'

module WebServers
  module Apache
    class Apache < WebServer

      Dir["#{__dir__}/scripts/*"].each { |f| require f }
      Dir["#{__dir__}/steps/*"].each { |f| require f }

      class << self
        def identifier
          'apache'
        end

        def step_precedence
          @@apache_step_precedence ||= { last: [:configure] }
        end

        def script_lot
          @@apache_script_lot ||= [:configuration]
        end
      end

    end
  end
end
