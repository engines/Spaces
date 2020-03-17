require_relative '../spaces/model'

module WebServers
  class WebServer < ::Spaces::Model

    # Dir["#{__dir__}/scripts/*"].each { |f| require f }
    # Dir["#{__dir__}/steps/*"].each { |f| require f }

    relation_accessor :context

    def struct
      @struct ||= context.struct.web_server
    end

    def initialize(context)
      self.context = context
    end

  end
end
