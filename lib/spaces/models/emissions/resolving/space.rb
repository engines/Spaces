module Resolving
  class Space < ::Settling::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate([:registry, :packs, :orchestrations] => :universe)

    def cascade_deletes; [:packs, :orchestrations] ;end

    def save(model)
      super.tap do
        copy_auxiliaries_for(blueprints, model)
        model.content.each { |t| save_text(t) }
      end
    end

    def bindings_to(model)
      all.map(&:bindings).map(&:all).flatten.select { |b| b.descriptor.identifier == model.blueprint_identifier }
    end

    protected

    def copy_auxiliaries_for(space, model)
      model.embeds_including_blueprint.map do |b|
        b.auxiliary_directories.each { |d| copy_auxiliaries(space, model, b, d) }
      end
    end

    def copy_auxiliaries(space, model, blueprint, segment)
      "#{segment}".tap do |s|
        space.path_for(blueprint).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(model)) if p.exist?
        end
      end
    end

  end
end
