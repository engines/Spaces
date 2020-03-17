require_relative '../web_server'

module WebServers
  class Apache < WebServer

    # Dir["#{__dir__}/scripts/*"].each { |f| require f }
    # Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def identifier
        'apache'
      end
    end

  end
end
