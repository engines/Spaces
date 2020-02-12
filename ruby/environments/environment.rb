require_relative '../products/product'
require_relative '../docker/files/collaboration'

module Environments
  class Environment < ::Products::Product
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@environment_step_precedence ||= {
          anywhere: [:variables, :locale, :ports]
        }
      end
    end

    def initialize(tensor)
      super
      self.struct = tensor.struct.environment
    end

  end
end
