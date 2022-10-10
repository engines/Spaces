module Registry
  class ConsumerEntry < Resolving::Emission

    class << self
      def composition_class = EntryComposition
    end

    alias_accessor :consumer, :resolution

    delegate(arena: :consumer)

    def bindings = division_map[:bindings]
    def binding = bindings.first

    def binding_identifier = binding.identifier
    def consumer_identifier = struct[:consumer_identifier]

    def service_identifier = service_connection.identifier

    def service_connection = arena.resolution_map[binding.identifier]

    def keys = composition.keys

    def cache_identifiers!
      struct.consumer_identifier = consumer.identifier
      struct.service_identifier = service_identifier
      struct.identifier = [service_identifier, consumer.identifier].join(identifier_separator)
    end

    def method_missing(m, *args, &block)
      binding.respond_to?(m) ? binding.send(m) : super
    end

    def respond_to_missing?(m, *)
      binding.respond_to?(m) || super
    end

  end
end
