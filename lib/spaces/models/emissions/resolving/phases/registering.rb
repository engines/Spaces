module Resolving
  module Registering

    def registered
      connect_bindings.map do |c|
        empty_entry.tap do |m|
          m.consumer = self
          m.struct = OpenStruct.new.tap { |s| s.bindings = [c.struct] }
          m.cache_identifiers!
        end
      end
    end

    def registrable?
      @registrable ||= connect_bindings.any?
    end

    def empty_entry = entry_class.new
    def entry_class = ::Registry::ConsumerEntry

    def service_path = registry.container_path_for(self)
    def full_service_path = registry.path_for(self)

  end
end
