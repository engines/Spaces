require_relative '../spaces/space'

module Installations
  class Space < ::Spaces::Space

    alias_method :super_save_yaml, :save_yaml

    def save_yaml(model)
      save_user_yaml(model)
      (model.savable_collaborators.compact).each { |s| super_save_yaml(s) }
    end

    def save_user_yaml(model)
      universe.users.save_yaml(model.user)
      super_save_yaml(model.user.as_installation_user)
    end

  end
end
