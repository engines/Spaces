require_relative '../installations/division'

module Environments
  class Environment < ::Installations::Division

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@environment_step_precedence ||= { anywhere: [:variables, :locale, :ports] }
      end
    end

    def variables
      struct.variables
    end

    def variable(name)
      variables.detect { |v| v.name == name.to_s }
    end

    def method_missing(m, *args, &block)
      (v = variable(m)) ? v.value : super
    end

  end
end
