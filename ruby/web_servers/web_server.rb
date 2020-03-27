require_relative '../installations/subdivision'

module WebServers
  class WebServer < ::Installations::Subdivision

    def struct
      @struct ||= context.struct.web_server
    end

    def subspace_path
      context.identifier
    end

    def build_script_path
       "#{context.super_build_script_path}/web_server/#{klass.identifier}"
    end

    def initialize(context)
      self.context = context
    end

  end
end
