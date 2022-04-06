module Orchestrating
  class Space < ::Emissions::Space

    class << self
      def default_model_class
        Orchestration
      end
    end

    delegate(
      [:arenas, :resolutions] => :universe
    )

    def cascade_deletes; [:registry] ;end

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(orchestration)
      ensure_connections_exist_for(orchestration)
      super.tap do
        translator_for(orchestration)&.save_artifacts_to(writing_path_for(orchestration))
      end
    end

    def commit(orchestration)
      interface_for(orchestration).commit
    end

    def delete(identifiable, cascade: true)
      super.tap do
        arena_path(identifiable.identifier).exist_then { delete }
      end
    end

    def provider_role; :orchestration ;end

    protected

    def ensure_connections_exist_for(orchestration)
      orchestration.connections_orchestrated.each { |p| save(p) }
    end

  end
end
