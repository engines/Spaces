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
      just_print_the_error(__FILE__, __LINE__, e)
      # warn(error: e, identifier: identifier, klass: klass)

      klass.new(blueprint: blueprints.by(identifier)).tap do |m|
        save(m)
      end
    end

    def save(model)
      super.tap do
        model.auxiliary_content.each { |t| save_text(t) }
      end
    end

  end
end
