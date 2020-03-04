require_relative '../docker/files/collaboration'
require_relative 'relationship'
require_relative 'anchor'

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
      @resolved ||= anchor.resolved_for(overrides_for(struct.variables))
    end

    def anchor
      @anchor ||= anchor_class.new(struct)
    end

    def descriptor
      anchor.descriptor
    end

    def anchor_class
      Anchor
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

    def method_missing(m, *args, &block)
      resolved.keys&.include?(m) ? resolved[m] : super
    end

  end
end
