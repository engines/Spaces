module Classifying
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class = Classifier
    end

  end
end
