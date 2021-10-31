module Provisioning
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    delegate(
      [:arenas, :resolutions] => :universe,
      provider_interface_for: :arenas
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
        provider_interface_for(provisions)&.save_artifacts
      end
    end

    def provider_interface_for(provisions)  #TODO: refactor
      provisions.arena.provisioning_provider.interface_for(provisions, self)
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
