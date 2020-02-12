require_relative '../products/product'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Frameworks
  class Framework < ::Products::Product
    include Images::Collaboration
    include Docker::Files::Collaboration

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
