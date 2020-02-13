require_relative '../collaborators/collaborator'

module Frameworks
  class Framework < ::Collaborators::Collaborator

    class << self
      def prototype(tensor)
        universe.frameworks.by(tensor)
      end
    end

    def port
      @port ||= struct.port || default_port
    end

    def default_port
    end

    def build_script_path
       "#{super}/framework/#{self.class.identifier}"
    end

    def struct
      @struct ||= tensor.struct.framework
    end

  end
end
