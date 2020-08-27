require_relative '../spaces/space'
require_relative 'defaultable'

module Defaultables
  module Space

    def default
      @default ||= default_model_class.new
    end

  end
end
