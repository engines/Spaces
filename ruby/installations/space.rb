require_relative '../universal/space'
require_relative 'installation'

module Installations
  class Space < ::Spaces::Space

    delegate([:blueprints, :users] => :universe)

    def by(descriptor, klass = default_model_class)
      by_yaml(descriptor, klass)
    rescue Errno::ENOENT
      default_model_class.new(blueprint: blueprints.by(descriptor))
    end

    def save(model)
      users.save(model.user)
      save_yaml(model)
    end

    def default_model_class
      Installation
    end

  end
end
