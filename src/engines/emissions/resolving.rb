module Emissions
  module Resolving

    def resolved_in(arena:)
      empty.tap do |m|
        m.struct = arena.struct.merge(struct)
        m.arena = arena
      end.resolved
    end

    def resolved
      empty.tap do |m|
        m.struct = m.struct.merge(
          OpenStruct.new(division_map.transform_values { |v| v.resolved.struct } )
        )
      end
    end

  end
end
