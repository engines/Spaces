require_relative '../tensors/collaborator'

module Frameworks
  class Framework < ::Tensors::Collaborator

    class << self
      def prototype(tensor)
        universe.frameworks.by(tensor)
      end
    end

    def port
      @port ||= struct.port || default_port
    end

    def cont_user
      'www-data'
    end
    
    def default_port
      8000
    end

    def build_script_path
       "#{super}/framework/#{self.class.identifier}"
    end

    def struct
      @struct ||= tensor.struct.framework
    end

  end
end
