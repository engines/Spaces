module Resolving
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate([:blueprints, :arenas, :packs, :provisioning] => :universe)

    def by(identifier)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def update(model)
      reset(model).tap do
        save_mirror(model)
      end
    end

    def reset(model)
      ensure_connections_reset_for(model)
      save_yaml(model).tap do
        reset_auxiliaries_for(model)
      end
    end

    def delete(identifiable)
      super.tap do
        packs.delete(identifiable) if packs.exist?(identifiable)
        provisioning.delete(identifiable) if provisioning.exist?(identifiable)
      end
    end

    def save(_)
      raise SimpleSaveDisallowed
    end

    def bindings_to(model)
      all.map(&:bindings).map(&:all).flatten.select { |b| b.descriptor.identifier == model.blueprint_identifier }
    end

    protected

    def ensure_connections_reset_for(model)
      model.connections_resolved.each { |r| reset(r) }
    end

    def reset_auxiliaries_for(model)
      copy_auxiliaries_for(blueprints, model)
      model.content.each { |t| save_text(t) }
    end

    def copy_auxiliaries_for(space, model)
      model.embeds_including_blueprint.map do |b|
        b.auxiliary_folders.each { |d| copy_auxiliaries(space, model, b, d) }
      end
    end

    def copy_auxiliaries(space, model, blueprint, segment)
      "#{segment}".tap do |s|
        space.path_for(blueprint).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(model)) if p.exist?
        end
      end
    end

    def save_mirror(model)
      path_for(model).join('mirror.yaml').write(model.to_yaml)
    end

  end

  class SimpleSaveDisallowed < ::Spaces::Errors::SpacesError ;end
end
