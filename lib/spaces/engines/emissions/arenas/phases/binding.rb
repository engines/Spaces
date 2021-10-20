module Arenas
  module Binding

    def bind_with(blueprint_identifier)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.bindings = bindings_merged_for(blueprint_identifier)
        end
      end
    end

    def bindings_merged_for(blueprint_identifier)
      [binding_for(blueprint_identifier), struct[:bindings]].compact.flatten.uniq
    end

    def binding_for(blueprint_identifier)
      OpenStruct.new(target_identifier: blueprint_identifier)
    end

  end
end
