require_relative '../collaborators/subdivision'

module WebServers
  class WebServer < ::Collaborators::Subdivision

    def struct
      @struct ||= context.struct.web_server
    end
    
    def path
      "#{collaborator_path}/web_server/#{klass.identifier}"
    end

    def initialize(context)
      self.context = context
    end

  end
end
