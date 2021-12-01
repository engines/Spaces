module Registry
  class Entry < Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :consumer

    delegate(arena: :consumer)

    def binding; bindings.first ;end

    def binding_identifier; binding.identifier ;end
    def service_identifier; struct[:service_identifier] ;end
    def consumer_identifier; struct[:consumer_identifier] ;end

    def cache_primary_identifiers
      struct.consumer_identifier = consumer.identifier
      struct.service_identifier = service_identifier
      struct.identifier = [service_identifier, consumer.identifier].join(identifier_separator)
    end

    def service_identifier
      service_connection.identifier
    end

    def service_connection
      arena.resolution_map[binding.identifier]
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
