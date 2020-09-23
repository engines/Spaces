module Spaces
  class Subspace < Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < default_model_class }
      end
    end

    delegate(loaded: :klass)

    def super_qualifier
      default_model_class.qualifier
    end

  end
end
