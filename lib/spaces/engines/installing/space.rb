module Installing
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Installation
      end
    end

    delegate([:blueprints, :arenas] => :universe)

    def by(identifier)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def save(model)
      super.tap do
        ensure_connections_exist_for(model)
      end
    end

    protected

    def ensure_connections_exist_for(model)
      model.connections_resolved.each { |r| save(r) }
    end

  end
end
