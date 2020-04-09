require_relative '../installations/subdivision'

module WebServers
  class WebServer < ::Installations::Subdivision

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
