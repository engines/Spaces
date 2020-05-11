require_relative '../collaborators/division'
require_relative 'schema'

module WebServers
  class WebServer < ::Collaborators::Division

    class << self
      def prototype(collaboration:, label:)
        universe.web_servers.by(collaboration)
      end

      def inheritance_paths; __dir__ ;end
    end

    def installation_path; "#{super}/#{klass.identifier}" ;end
    
    def struct; @struct ||= collaboration.struct.web_server ;end

  end
end
