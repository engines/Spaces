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
        m.struct = divisions.map(&:resolved).map(&:struct)
      end
    end

  end
end
