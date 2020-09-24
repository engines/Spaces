module Resolving
  class Space < ::Spaces::TurtleSpace

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate(blueprints: :universe)

    def by(descriptor, klass = default_model_class)
      by_yaml(descriptor, klass)
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, klass: klass)
      klass.new(blueprint: blueprints.by(descriptor)).tap do |m|
        save(m)
      end
    end

    def save(model)
      model.auxiliary_texts.map do |t|
        save_text(t)
        "#{t.emission_path}"
      end

      super
    end

  end
end
