require_relative '../../emissions/subdivision_space'
require_relative 'image'

module Packing
  module Images
    class Space < Emitting::SubdivisionSpace

      class << self
        def default_model_class
          Image
        end
      end

      def load(type)
        require_relative("#{type}/#{type}")
      end

    end
  end
end
