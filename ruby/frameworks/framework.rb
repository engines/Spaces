require_relative '../products/product'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Frameworks
  class Framework < ::Products::Product
    include Images::Collaboration
    include Docker::Files::Collaboration

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
