require 'ruby_terraform'
require_relative '../spaces/space'

module Terraform
  class Space < ::Spaces::Space
    extend RubyTerraform

    def save(model)
      model.components.each { |t| save_text(t) }
      _save(model, content: model.content, as: :tf)
    end

  end
end
