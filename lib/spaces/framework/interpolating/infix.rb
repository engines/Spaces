module Interpolating
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate(
      [:transformable, :interpolation_marker] => :text,
      emission: :transformable
    )

    def resolved
      @resolved ||= complete? ? resolved_once : resolved_again
    end

    def resolved_once
      @resolved_once ||= _resolved
    end

    def resolved_again
      Text.new(origin: resolved_once, transformable: transformable).resolved
    end

    def complete?
      !more_to_resolve? || unresolvable?
    end

    def more_to_resolve?
      resolved_once.to_s.include?(interpolation_marker)
    rescue NoMethodError => e
      false
    end

    def unresolvable?
      value == resolved_once.gsub(interpolation_marker, '')
    end

    def acceptable_method_chain_in_value
      @amc ||= ([:unqualified] + value.split('.')).last(2)
    end

    alias_method :amc, :acceptable_method_chain_in_value

    def object_in_value; amc.first ;end
    def method_in_value; amc.last.split(/[()]+/) ;end

    def collaborator
      object_in_value == :unqualified ? unqualified_collaborator : qualified_collaborator
    end

    def qualified_collaborator
      service_collaborator || configuration_collaborator ||  other_collaborator
    end

    def service_collaborator
      if (b = emission.respond_to?(:bindings) && emission.bindings&.named(object_in_value))
        return b.struct.configuration if b.embed? && b.struct.configuration.respond_to?(method_in_value.first)
        b.service if b.service.respond_to?(method_in_value.first)
      end
    end

    def configuration_collaborator
      if emission.respond_to?(:binding_target) && emission.binding_target.respond_to?(:configuration)
        emission.binding_target.configuration if emission.binding_target.configuration.respond_to?(method_in_value.first)
      end
    end

    def other_collaborator
      emission.respond_to?(object_in_value) && emission.send(object_in_value)
    end

    def unqualified_collaborator
      transformable
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s; resolved ;end

    protected

    def _resolved
      collaborator.send(*method_in_value)
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value, qualifier: emission.qualifier, identifier: emission.identifier)
      pp e
      text.to_s
      # raise ::Interpolating::Errors::Unresolvable
    end

  end

  module Errors
    class Unresolvable < ::Spaces::Errors::SpacesError
    end
  end
end
