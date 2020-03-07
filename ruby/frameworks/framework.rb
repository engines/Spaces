require_relative '../installations/collaborator'

module Frameworks
  class Framework < ::Installations::Collaborator

    class << self
      def prototype(installation:, section:)
        universe.frameworks.by(installation)
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
      @struct ||= installation.struct.framework
    end

  end
end
