module Settling
  class Space < ::Emissions::Space

    delegate([:blueprints, :arenas] => :universe)

    def by(settlement)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

  end
end
