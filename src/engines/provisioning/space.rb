module Provisioning
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    delegate([:arenas, :resolutions] => :universe)

    def identifiers(arena_identifier: '*', resolution_identifier: '*')
      path.glob("#{arena_identifier}/#{resolution_identifier}").map do |p|
        p.relative_path_from(path)
      end
    end

    def save(model)
      if model.resolution.has?(:containers)
        Pathname.new("#{arenas.path}/#{model.identifier}.tf").write(model.stanzas_content)
      end
      super
    end

    protected

    def unique_target_resolutions_for(resolution)
      resolution.targets&.uniq(&:uniqueness) || []
    end

  end
end
