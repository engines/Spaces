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

  end
end
