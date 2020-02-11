require_relative '../spaces/model'
require_relative '../docker/files/collaboration'

module Environments
  class Environment < ::Spaces::Model
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@environment_step_precedence ||= {
          anywhere: [:variables, :locale, :ports]
        }
      end
    end

    def initialize(struct)
      self.struct = struct
    end

  end
end
