require_relative '../installations/division'

module Frameworks
  class Framework < ::Installations::Division

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def prototype(installation:, blueprint_label:)
        universe.frameworks.by(installation)
      end

      def script_lot
        @@framework_script_lot ||= [:installation, :finalisation, :chown_app_dir]
      end
    end

    relation_accessor :web_server

    alias_method :super_build_script_path, :build_script_path

    def scripts
      [super, web_server.scripts]
    end

    def all
    end

    def layers_for(group)
      [super, web_server.layers_for(group)]
    end

    def web_server
      @web_server ||= universe.web_servers.by(self)
    end

    def port
      @port ||= struct.port || default_port
    end

    def user_identifier
      'www-data'
    end

    def default_port
      8000
    end

    def build_script_path
       "#{super}/framework/#{klass.identifier}"
    end

    def struct
      @struct ||= installation.struct.framework
    end

  end
end
