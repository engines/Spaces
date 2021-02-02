module Resolving
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate(blueprints: :universe)

    def save(model)
      ensure_connections_exist_for(model)
      super.tap do
        copy_auxiliaries_for(model)
        model.content.each { |t| save_text(t) }
      end
    end

    protected

    def ensure_connections_exist_for(model)
      absent(model.connections_resolved).each { |r| save(r) }
    end

    def copy_auxiliaries_for(model)
      model.embeds_including_blueprint.map do |b|
        b.auxiliary_directories.each { |d| copy_auxiliaries(model, b, d) }
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
