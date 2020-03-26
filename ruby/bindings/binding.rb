require_relative '../docker/files/collaboration'
require_relative '../texts/text'

module Bindings
  class Binding < ::Spaces::Model
    include Docker::Files::Collaboration

    relation_accessor :context

    class << self
      def step_precedence
        @@binding_step_precedence ||= { anywhere: [:variables] }
      end
    end

    def product
      duplicate(struct).tap { |s| s.variables = resolved }
    end

    def resolved
      @resolved ||=
        keys.inject(OpenStruct.new) do |s, k|
          s[k] = text_class.new(source: overrides[k], context: self).resolved
          s
        end
    end

    def text_class
      Texts::Text
    end

    def keys
      overrides.to_h.keys
    end

    def overrides
      @overrides ||= default_variables.merge(variables)
    end

    def variables
      struct.variables || OpenStruct.new
    end

    def default_variables
      @default_variables ||= anchor_installation.binding_anchor&.variables
    end

    def anchor_installation
      @anchor_installation ||= universe.installations.by(descriptor)
    rescue Errno::ENOENT
      universe.blueprints.by(descriptor).installation
    end

    def installation
      context.installation
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def identifier
      struct.identifier || descriptor.identifier
    end

    def random(length)
      SecureRandom.hex(length.to_i)
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

    def method_missing(m, *args, &block)
      keys&.include?(m) ? resolved[m] : super
    end

  end
end
