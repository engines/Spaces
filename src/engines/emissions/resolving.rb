module Emissions
  module Resolving

    def resolved_in(arena)
      empty_resolution.tap do |m|
        m.predecessor = self
        m.arena = arena
        m.struct = arena.struct.merge(struct)
        m.struct.identifier = "#{arena.identifier}/#{identifier}"
      end.resolved
    end

    def resolved
      empty.tap do |m|
        m.predecessor = predecessor
        m.struct = m.struct.merge(
          OpenStruct.new(division_map.transform_values { |v| v.resolved.struct } )
        )
      end
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
