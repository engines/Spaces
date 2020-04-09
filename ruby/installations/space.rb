require_relative '../spaces/space'

module Installations
  class Space < ::Spaces::Space

    alias_method :by, :by_yaml
    alias_method :save, :save_yaml

    def save_yaml(model)
      save_user(model)
      super
    end

    def save_user(model)
      universe.users.save(model.user)
    end

    def default_model_class
      Installation
    end

  end
end
