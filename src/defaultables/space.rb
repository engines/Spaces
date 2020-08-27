require_relative '../spaces/space'
require_relative 'defaultable'

module Defaultables
  module Space

    def default
      @default ||= default_model_class.new.tap do |m|
        m.struct = m.default
      end
    end

  end
end
