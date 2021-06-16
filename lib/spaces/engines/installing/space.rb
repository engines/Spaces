module Installing
  class Space < ::Settling::Space

    class << self
      def default_model_class
        Installation
      end
    end

  end
end
