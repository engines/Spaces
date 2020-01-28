require_relative '../spaces/model'
require_relative '../docker/file/collaboration'

module Environment
  class Environment < ::Spaces::Model
    include Docker::File::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@dependency_step_precedence ||= {
          anywhere: [:variables, :locale, :ports]
        }
      end
    end

    def initialize(struct)
      self.struct = struct
    end

  end
end
