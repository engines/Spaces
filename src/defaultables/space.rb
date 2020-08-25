require_relative '../spaces/space'
require_relative 'defaultable'

module Defaultables
  class Space < ::Spaces::Space

    def default
      @default ||= default_model_class.new
    end

  end
end
