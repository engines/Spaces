require_relative '../spaces/model'
require_relative '../container/docker/collaboration'

module Domain
  class Domain < ::Spaces::Model
    include Container::Docker::Collaboration

    class << self
      def step_precedence
        @@domain_step_precedence ||= [:variables]
      end
    end

    def layers
      step_precedence.each { |s| require_relative "steps/#{s}" }
      super
    end

    def step_module_name
      "Domain"
    end

  end
end
