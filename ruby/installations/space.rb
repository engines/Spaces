require_relative '../spaces/space'

module Installations
  class Space < ::Spaces::Space

    alias_method :super_save_yaml, :save_yaml

    def save_yaml(model)
      (model.savable_collaborators).each { |s| super_save_yaml(s) }
    end

  end
end
