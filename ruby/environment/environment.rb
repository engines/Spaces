require_relative '../spaces/model'
require_relative '../container/docker/collaboration'

module Environment
  class Environment < ::Spaces::Model
    include Container::Docker::Collaboration

    class << self
      def step_precedence
        @@environment_step_precedence ||= [:variables]
      end
    end

    def layers
      step_precedence.each { |s| require_relative "steps/#{s}" }
      super
    end

    def step_module_name
      "Environment"
    end

    def locale
      @locale ||= struct.locale
    end

  end
end
