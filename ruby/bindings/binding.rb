require_relative '../docker/files/collaboration'
require_relative 'relationship'
require_relative 'service'

module Bindings
  class Binding < Relationship
    include Docker::Files::Collaboration

    relation_accessor :context

    class << self
      def step_precedence
        @@binding_step_precedence ||= { anywhere: [:variables] }
      end
    end

    def resolved
      @resolved ||= service.resolved_for(overrides_for(struct.variables))
    end

    def service
      @service ||= service_class.new(struct)
    end

    def service_class
      Service
    end

    def descriptor
      service.descriptor
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
