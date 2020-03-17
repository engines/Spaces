require_relative '../installations/collaborator'

module Frameworks
  class Framework < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def prototype(installation:, section:)
        universe.frameworks.by(installation)
      end

      def script_lot
        @@framework_script_lot ||= [:configuration, :installation, :finalisation, :chown_app_dir]
      end
    end

    relation_accessor :web_server

    def web_server
      @web_server ||= universe.web_servers.by(self)
    end

    def framework_identifier
      self.class.identifier
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
       "#{super}/framework/#{framework_identifier}"
    end

    def struct
      @struct ||= installation.struct.framework
    end

  end
end
