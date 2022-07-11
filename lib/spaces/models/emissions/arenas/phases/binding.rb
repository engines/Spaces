module Arenas
  module Binding

    def deep_connect_bindings
      super.map do |b|
        binding_class.new(b, self)
      end
    end

    def inject_bindings =
      bindings.map(&:inject_bindings).flatten.compact.uniq

    def bind_with(blueprint_identifier)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.bindings = bindings_merged_for(blueprint_identifier)
        end
      end
    end

    def bindings_merged_for(blueprint_identifier) =
      [binding_for(blueprint_identifier), struct[:bindings]].compact.flatten.uniq

    def binding_for(blueprint_identifier) =
      OpenStruct.new(target_identifier: blueprint_identifier)

    def more_binder_identifiers =
      blueprints.binder_identifiers - target_identifiers

    def connectable_blueprints
      connected_blueprints.map do |b|
        b.binder? ? b.connected_blueprints.flatten.map(&:blueprint) : b
      end.flatten.uniq(&:uniqueness)
    end

  end
end
