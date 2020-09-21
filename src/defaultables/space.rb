require_relative '../spaces/models/space'
require_relative 'defaultable'

module Defaultables
  module Space

    def default
      @default ||= default_specific_class.new.tap do |m|
        m.struct = m.default
      end
    end

    def default_specific_class; default_model_class ;end

  end
end
