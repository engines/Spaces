require_relative '../spaces/model'
require_relative '../container/docker/collaboration'

module Domain
  class Domain < ::Spaces::Model
    include Container::Docker::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@dependency_step_precedence ||= { anywhere: [:variables] }
      end
    end

  end
end
