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

    def save(installation)
      super.tap do
        ensure_connections_exist_for(installation)
      end
    end

    protected

    def ensure_connections_exist_for(installation)
      installation.connections_installed.each { |i| save(i) }
    end

  end
end
