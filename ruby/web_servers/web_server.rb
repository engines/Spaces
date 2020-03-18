require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module WebServers
  class WebServer < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    relation_accessor :context

    def struct
      @struct ||= context.struct.web_server
    end

    def subspace_path
      context.identifier
    end

    def build_script_path
       "#{context.super_build_script_path}/web_server/#{class_identifier}"
    end

    def class_identifier
      self.class.identifier
    end

    def initialize(context)
      self.context = context
    end

  end
end
