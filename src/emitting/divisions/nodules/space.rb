module Nodules
  class Space < ::Spaces::Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < Nodule }
      end
    end

    delegate(loaded: :klass)

    relation_accessor :context

    def by(struct:, division:)
      loaded.detect { |k| k.qualifier == struct.type }.new(struct: struct, division: division)
    end

  end
end
