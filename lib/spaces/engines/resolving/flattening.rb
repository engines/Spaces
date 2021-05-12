module Resolving
  module Flattening

    def flattened
      bindings.any? ? _flattened : self
    end

    protected

    def _flattened
      empty.tap do |m|
        m.predecessor = predecessor
        m.struct = struct
        m.struct.bindings = bindings.flattened.struct
      end
    end

  end
end
