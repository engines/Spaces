require_relative '../universal/space'
require_relative 'installation'

module Installations
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Installation
      end
    end

    delegate(blueprints: :universe)

    def by(descriptor, klass = default_model_class)
      by_yaml(descriptor, klass)
    rescue Errno::ENOENT
      default_model_class.new(blueprint: blueprints.by(descriptor))
    end

    def save(model)
      universe.users.save(model.user)
      super
    end

  end
end
