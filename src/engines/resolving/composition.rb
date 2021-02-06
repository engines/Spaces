module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        blend_associative_classes_of(::Arenas::Composition, super)
      end

      def blend_associative_classes_of(composition, classes)
        [classes, composition.associative_classes].flatten
      end
    end

  end
end
