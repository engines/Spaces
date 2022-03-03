module Interpolating
  class Infix < ::Spaces::Model

    attr_accessor :original_value
    attr_accessor :last_iteration
    relation_accessor :text

    delegate(
      [:transformable, :interpolation_marker] => :text,
      emission: :transformable
    )

    def resolved
      resolvable? ? completed : "#{interpolation_marker}#{original_value}#{interpolation_marker}"
    end

    def resolvable?
      working_value != once
    end

    def completed
      @completed ||= complete? ? once : again
    end

    def complete?
      (!once.include?(interpolation_marker))
    rescue NoMethodError => e
      true
    end

    def once
      @once ||= iteration
    end

    def again
      klass.new(original_value: original_value, text: text, last_iteration: once.gsub(interpolation_marker, '')).resolved
    end

    def iteration
      collaborator.send(*method_in_expression)
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: working_value, qualifier: emission.qualifier, identifier: emission.identifier)
      pp e
      original_value
      # raise ::Interpolating::Errors::Unresolvable
    end

    def object_in_expression; acceptable_expression.first ;end
    def method_in_expression; acceptable_expression.last.split(/[()]+/) ;end

    def acceptable_expression
      @acceptable_expression ||= ([:unqualified] + working_value.split('.')).last(2)
    end

    def working_value
      last_iteration || original_value
    end

    def collaborator
      object_in_expression == :unqualified ? unqualified_collaborator : qualified_collaborator
    end

    def qualified_collaborator
      service_collaborator || configuration_collaborator ||  other_collaborator
    end

    def service_collaborator
      if (b = emission.respond_to?(:bindings) && emission.bindings&.named(object_in_expression))
        return b.struct.configuration if b.embed? && b.struct.configuration.respond_to?(method_in_expression.first)
        b.service if b.service.respond_to?(method_in_expression.first)
      end
    end

    def configuration_collaborator
      if emission.respond_to?(:binding_target) && emission.binding_target.respond_to?(:configuration)
        emission.binding_target.configuration if emission.binding_target.configuration.respond_to?(method_in_expression.first)
      end
    end

    def other_collaborator
      emission.respond_to?(object_in_expression) && emission.send(object_in_expression)
    end

    def unqualified_collaborator
      transformable
    end

    def initialize(original_value:, text:, last_iteration: nil)
      self.original_value = original_value
      self.last_iteration = last_iteration
      self.text = text
    end

    def to_s; resolved ;end

  end

  module Errors
    class Unresolvable < ::Spaces::Errors::SpacesError
    end
  end
end
