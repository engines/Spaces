module Installing
  class Space < ::Settling::Space

    class << self
      def default_model_class
        Installation
      end
    end

    def cascade_deletes; [:resolutions] ;end

  end
end
