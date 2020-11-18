module Resolving
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate(blueprints: :universe)

    def by(identifier, klass = default_model_class)
      by_yaml(identifier, klass).tap do |m|
        m.blueprint = blueprints.by(identifier)
      end
    rescue Errno::ENOENT => e
      warn(error: e, identifier: identifier, klass: klass)
      klass.new(blueprint: blueprints.by(identifier)).tap do |m|
        save(m)
      end
    end

    def save(model)
      model.auxiliary_content.map do |t|
        save_text(t)
        "#{t.emission_path}"
      end

      super
    end

  end
end
