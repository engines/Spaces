require_relative '../installations/collaborator'

module Frameworks
  class Framework < ::Installations::Collaborator

    class << self
      def prototype(installation:, section:)
        universe.frameworks.by(installation)
      end
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
