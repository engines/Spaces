require_relative '../spaces/space'

module Nodules
  class Space < ::Spaces::Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < Nodule }
      end
    end

    delegate(loaded: :klass)

    relation_accessor :context

    def by(struct:, context:)
      load(struct.type)
      loaded.detect { |k| k.qualifier == struct.type }.new(struct: struct, context: context)
    end

    def load(type)
      require_relative("#{type}/#{type}")
    end

  end
end
