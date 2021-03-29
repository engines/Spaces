module Provisioning
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    delegate([:arenas, :resolutions] => :universe)

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}"
      end
    end

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(model)
      ensure_connections_exist_for(model)
      if model.resolution.provisioning_allowed?
        Pathname.new("#{arenas.path}/#{model.identifier}.tf").write(model.payload)
      end
      super
    end

    protected

    def ensure_connections_exist_for(model)
      model.connections_provisioned.each { |p| save(p) }
    end

  end
end
