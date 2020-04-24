require_relative '../collaborators/subdivision'
require_relative 'schema'

module WebServers
  class WebServer < ::Collaborators::Subdivision

    class << self
      define_method (:schema_class) { Schema }
    end

    define_method (:struct) { @struct ||= context.struct.web_server }
    define_method (:path) { "#{collaborator_path}/web_server/#{klass.identifier}" }

    def initialize(context)
      self.context = context
    end

  end
end
