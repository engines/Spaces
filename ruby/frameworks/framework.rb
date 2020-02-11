require_relative '../spaces/model'
require_relative '../docker/files/collaboration'

module Frameworks
  class Framework < ::Spaces::Model
    include Docker::Files::Collaboration

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
