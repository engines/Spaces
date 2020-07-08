require_relative '../universal/space'
require_relative 'resolution'

module Resolutions
  class Space < ::Spaces::Space

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
      model.components.map do |t|
        save_text(t)
        "#{t.release_path}"
      end

      super
    end

  end
end
