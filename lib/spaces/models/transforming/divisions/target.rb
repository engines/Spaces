module Divisions
  class Target < ::Divisions::Division

    def inflated = self
    def deflated = self

    def resolved
      empty.tap do |d|
        d.struct = struct
        d.struct.configuration = if (c = struct.configuration)
          resolvable_struct_class.new(c, self).resolved
        end
      end
    end

  end
end
