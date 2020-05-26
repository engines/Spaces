require_relative '../releases/division'
require_relative 'schema'

module WebServers
  class WebServer < ::Releases::Division

    class << self
      def prototype(stage:, label:)
        universe.web_servers.by(stage)
      end

      def inheritance_paths; __dir__ ;end
    end

    def release_path; "#{super}/#{klass.identifier}" ;end
    
    def struct; @struct ||= stage.struct.web_server ;end

  end
end
