module Interpolating
  module Resolving

    def iteration
      collaborator.send(*method_in_expression)
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, method: :iteration,
        elements: nesting_elements, identifier: emission.identifier, qualifier: emission.qualifier, text: text.to_s, value: working_value
      )
      original_value
      # raise ::Interpolating::Errors::Unresolvable
    end

    def collaborator =
      object_in_expression == :unqualified ? unqualified_collaborator : qualified_collaborator

    def qualified_collaborator =
      service_collaborator || configuration_collaborator ||  other_collaborator

    def service_collaborator =
      if (b = emission.respond_to?(:bindings) && emission.bindings&.named(object_in_expression))
        return b.struct.configuration if b.embed? && b.struct.configuration.respond_to?(method_in_expression.first)
        b.service if b.service.respond_to?(method_in_expression.first)
      end

    def configuration_collaborator =
      if emission.respond_to?(:binding_target) && emission.binding_target.respond_to?(:configuration)
        emission.binding_target.configuration if emission.binding_target.configuration.respond_to?(method_in_expression.first)
      end

    def other_collaborator =
      emission.respond_to?(object_in_expression) && emission.send(object_in_expression)

    def unqualified_collaborator = transformable

  end
end
