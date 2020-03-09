require_relative '../spaces/space'

module Installations
  class Space < ::Spaces::Space

    alias_method :super_save_yaml, :save_yaml

    def save_yaml(model)
      model.collaborators.values.each { |c| super_save_yaml(c) }
    end

  end
end
