require_relative '../spaces/space'

module Nodule
  class Space < ::Spaces::Space

    relation_accessor :context

    def by(struct:, context:)
      load(struct.type)
      loaded.detect { |k| k.identifier == struct.type }.new(struct: struct, context: context)
    end

    def loaded
      ObjectSpace.each_object(Class).select { |k| k < Nodule }
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

  end
end
