module Arenas
  module Binding

    def bind_with(blueprint_identifier) # NOW WHAT?
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.bindings = bindings_merged_for(blueprint_identifier) # NOW WHAT?
        end
      end
    end

    def bindings_merged_for(blueprint_identifier) # NOW WHAT?
      [binding_for(blueprint_identifier), struct[:bindings]].compact.flatten.uniq
    end

    def binding_for(blueprint_identifier) # NOW WHAT?
      OpenStruct.new(target_identifier: blueprint_identifier)
    end

    def more_binder_identifiers
      blueprints.binder_identifiers - target_identifiers
    end

    def connectable_blueprints
      connected_blueprints.map do |b|
        b.binder? ? b.connected_blueprints.flatten.map(&:blueprint) : b
      end.flatten.uniq(&:uniqueness)
    end

  end
end
