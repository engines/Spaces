module Provisioning
  class Space < ::Emissions::Space

    class << self
      def default_model_class
        Provisions
      end
    end

    # delegate(
    #   arenas: :universe,
    #   path: :arenas
    # )

    def identifiers(arena_identifier = '*')
      Pathname.glob("#{path}/#{arena_identifier}/*").map { |p| p.to_s.split('/').last(2).join('/') }
    end

    def save(model)
      anchor_provisionings_for(model).each { |p| save(p) }

      _save(model, content: model.stanzas_content, as: :tf) unless model.has?(:containers)
      super
    end

    def anchor_provisionings_for(model)
      anchor_resolutions_for(model.resolution).map do |r|
        default_model_class.new(resolution: r, arena: model.arena)
      end
    end


  end
end
