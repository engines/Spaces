require_relative '../collaborators/subdivision'
require_relative 'schema'

module WebServers
  class WebServer < ::Collaborators::Subdivision

    class << self
      def schema_class; Schema ;end
    end

    def struct; @struct ||= division.struct.web_server ;end
    def path; "#{collaborator_path}/web_server/#{klass.identifier}" ;end

    def initialize(division)
      self.division = division
    end

  end
end
