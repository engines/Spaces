require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

module Framework
  class Framework < ::Spaces::Model
    include Docker::File::Collaboration

    def port
      @port ||= struct.port || default_port
    end

    def default_port
    end

    def identifier
      self.class.identifier
    end

  end
end
