module Providers
  class Provider < ::Spaces::Model

    attr_accessor :role

    def interface_for(arena_emission, space = nil)
      interface_class.new(adapter_for(arena_emission), space)
    end

    def adapter_for(arena_emission)
      adapter_class_for(arena_emission.qualifier).new(arena_emission)
    end

    def interface_class
      [name_elements, :interface].flatten.uniq.constantize #TODO: refactor
    end

    def adapter_class_for(qualifier)
      [name_elements, "#{qualifier}_adapter"].flatten.uniq.constantize
    end

    def initialize(role)
      self.role = role
    end

  end
end
