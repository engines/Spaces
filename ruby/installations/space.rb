require_relative '../spaces/space'

module Installations
  class Space < ::Spaces::Space

    def save_yaml(model)
      save_user_yaml(model)
      super
    end

    def save_user_yaml(model)
      universe.users.save_yaml(model.user)
    end
    
  end
end
