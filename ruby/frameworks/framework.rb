require_relative '../collaborators/division'

module Frameworks
  class Framework < ::Collaborators::Division

    class << self
      def prototype(collaboration:, label:)
        universe.frameworks.by(collaboration)
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps, :scripts

    relation_accessor :web_server

    def scripts; [super, web_server.scripts] ;end
    def layers_for(group); [super, web_server.layers_for(group)] ;end

    def web_server; @web_server ||= universe.web_servers.by(self) ;end
    def all; [web_server] ;end

    def port; @port ||= struct.port || default_port ;end
    def default_port; 8000 ;end

    def data_uid; collaboration.user.data_uid ;end
    def data_gid; collaboration.user.data_gid ;end
    def user_name; 'www-data' ;end

    def installation_path; "#{super}/#{klass.identifier}" ;end

    def struct; @struct ||= collaboration.struct.framework ;end

  end
end
