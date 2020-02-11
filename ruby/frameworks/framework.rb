require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Frameworks
  class Framework < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def script_precedence
        @@nodule_script_precedence ||= []
      end
    end

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
