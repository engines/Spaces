module Packing
  module Images
    class Space < Emissions::SubdivisionSpace

      class << self
        def default_model_class
          Image
        end
      end

    end
  end
end
