module Provisioning
  class Space < ::Emissions::Space

    class << self
      def default_model_class
        Provisions
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

    def save(provisions)
      ensure_connections_exist_for(provisions)
      super.tap do
        adapting_interface_for(provisions)&.save_artifacts
      end
    end

    def commit(provisions)
      adapting_interface_for(provisions).commit
    end

    def adapting_interface_for(provisions)  #TODO: refactor
      provisions.arena.provisioning_provider.adapting_interface_for(provisions, purpose: :provisioning, space: space)
    end

    def delete(identifiable, cascade: true)
      super.tap do
        arena_path(identifiable.identifier).exist_then { delete }
      end
    end

    protected

    def ensure_connections_exist_for(provisions)
      provisions.connections_provisioned.each { |p| save(p) }
    end

  end
end
