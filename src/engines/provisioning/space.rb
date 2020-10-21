module Provisioning
  class Space < ::Emissions::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    delegate(
      arenas: :universe,
      path: :arenas
    )

    def save(model)
      anchor_provisionings_for(model).each { |p| save(p) }

      _save(model, content: model.stanzas_content, as: :tf) unless model.has?(:containers)
    end

    def anchor_provisionings_for(model)
      anchor_resolutions_for(model.resolution).map do |r|
        default_model_class.new(resolution: r, arena: model.arena)
      end
    end

    def path_for(model)
      [path, model.arena.identifier, model.subpath].compact.join('/')
    end

  end
end
