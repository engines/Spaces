require_relative '../spaces/model'
require_relative '../container/docker/collaboration'

module Framework
  class Framework < ::Spaces::Model
    include Container::Docker::Collaboration

    def identifier
      self.class.identifier
    end

  end
end
