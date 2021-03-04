require 'resolv'

module Divisions
  class Binding < ::Divisions::TargetingSubdivision

    alias_accessor :arena, :emission

    def type; struct.type ;end
    def embed?; type == 'embed' ;end

    def localised
      empty.tap do |m|
        m.struct = struct.without(:target).tap do |s|
          s.target_identifier = target_identifier
        end
      end
    end

    def inflated
      empty.tap do |m|
        m.struct = struct.tap do |s|
          s.configuration = inflated_configuration
        end
      end
    end

    def inflated_configuration
      unresolved_struct.merge(target_configuration).merge(struct_configuration)
    end

    def resolved
      super.tap do |d|
        d.struct.configuration = Divisions::ResolvableStruct.new(struct.configuration, self).resolved
      end
    end

    def infix_qualifier; target_identifier ;end

    def target_configuration
      @target_configuration ||=
      if blueprint.has?(:binding_target)
        blueprint.binding_target&.struct
      end || OpenStruct.new
    end

    def struct_configuration; struct.configuration || OpenStruct.new ;end

    def keys; struct_configuration.to_h.keys ;end

    def method_missing(m, *args, &block)
      keys&.include?(m) ? struct_configuration[m] : super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m) || super
    end

  end
end
