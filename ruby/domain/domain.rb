require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

module Domain
  class Domain < ::Spaces::Model
    include Docker::File::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@dependency_step_precedence ||= { anywhere: [:variables] }
      end
    end

  end
end
