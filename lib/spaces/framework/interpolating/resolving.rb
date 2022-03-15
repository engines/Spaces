module Interpolating
  module Resolving

    def iteration
      collaborator.send(*method_in_expression)
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: working_value, qualifier: emission.qualifier, identifier: emission.identifier)
      pp e
      original_value
      # raise ::Interpolating::Errors::Unresolvable
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

  end
end
