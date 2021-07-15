require_relative 'status'

module Registry
  class Entry < Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :consumer

    def binding_identifier; binding.identifier ;end
    def arena_identifier; struct[:arena_identifier] ;end
    def blueprint_identifier; struct[:blueprint_identifier] ;end

    def binding; bindings.first ;end

    def cache_primary_identifiers
      struct.arena_identifier = consumer.arena_identifier
      struct.blueprint_identifier = consumer.blueprint_identifier
      struct.identifier = [arena_identifier, target_identifier, binding_identifier, blueprint_identifier].join(identifier_separator)
    end

    def keys; composition.keys ;end

    def method_missing(m, *args, &block)
      binding.respond_to?(m) ? binding.send(m) : super
    end

    def respond_to_missing?(m, *)
      binding.respond_to?(m) || super
    end

  end
end
