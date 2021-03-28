module Resolving
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate([:blueprints, :arenas] => :universe)

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}"
      end
    end

    def by(identifier)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def save(model)
      ensure_connections_exist_for(model)
      super.tap do
        copy_auxiliaries_for(model)
        model.content.each { |t| save_text(t) }
      end
    end

    def bindings_to(model)
      all.map(&:bindings).map(&:all).flatten.select { |b| b.descriptor.identifier == model.blueprint_identifier }
    end

    protected

    def ensure_connections_exist_for(model)
      model.connections_resolved.each { |r| save(r) }
    end

    def copy_auxiliaries_for(model)
      model.embeds_including_blueprint.map do |b|
        b.auxiliary_folders.each { |d| copy_auxiliaries(model, b, d) }
      end
    end

    def copy_auxiliaries(model, blueprint, segment)
      "#{segment}".tap do |s|
        blueprints.path_for(blueprint).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(model)) if p.exist?
        end
      end
    end

  end
end
