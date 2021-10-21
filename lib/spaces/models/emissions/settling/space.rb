module Settling
  class Space < ::Spaces::Space

    delegate([:blueprints, :arenas] => :universe)

    def by(settlement)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def save(settlement)
      super.tap do
        ensure_connections_exist_for(settlement)
      end
    end

    protected

    def ensure_connections_exist_for(settlement)
      settlement.connections_settled.each { |s| save(s) }
    end

  end
end
