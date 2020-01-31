require_relative '../spaces/space'

module Nodule
  class Space < ::Spaces::Space

    def by(struct)
      load(struct.type)
      loaded.detect { |k| k.identifier == struct.type }.new(struct)
    end

    def loaded
      ObjectSpace.each_object(Class).select { |k| k < Nodule }
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

  end
end
