require_relative 'space'

module Spaces
  class Subspace < Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < default_model_class }
      end
    end

    delegate(loaded: :klass)

    def by(collaboration)
      i = collaboration.struct[super_qualifier].identifier
      load(i)
      loaded.detect { |k| k.identifier == i }.new(collaboration: collaboration, label: super_qualifier)
    end

    def super_qualifier
      default_model_class.qualifier
    end

    def load(identifier) ;end

  end
end
