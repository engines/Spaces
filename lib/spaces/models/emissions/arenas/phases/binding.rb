module Arenas
  module Binding # NOW WHAT?

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

  end
end
