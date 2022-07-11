require_relative 'arenas'
require_relative 'summary'
require_relative 'relations'

module Blueprinting
  class Blueprint < Publishing::Blueprint
    include Inflating
    include Resolving
    include Arenas
    include Summary
    include Relations

    delegate(
      [:locations, :arenas] => :universe,
      descendant_paths: :bindings
    )

    alias_method :blueprint, :itself

    def application_identifier = struct.application_identifier || super

    def binder? = only_defines?(:bindings)

    def descriptor
      @descriptor ||= blueprints.by(identifier, Spaces::Descriptor)
    end

    def transformed_for_publication = globalized

    def cache_identifiers!(binding)
      struct.blueprint_identifier = binding.target_identifier
      struct.identifier = binding.target_identifier
      struct.application_identifier = binding.application_identifier
    end

  end
end
