require_relative '../web_server'

module WebServers
  module Apache
    class Apache < WebServer

      class << self
        def identifier
          'apache'
        end

        def step_precedence
          { last: [:configure] }
        end

        def inheritance_paths; __dir__; end
      end

      require_files_in :steps, :scripts

    end
  end
end
