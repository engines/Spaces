require_relative '../../releases/subdivision_space'
require_relative 'builder'

module Packing
  module Builders
    class Space < Releases::SubdivisionSpace

      class << self
        def default_model_class
          Builder
        end
      end

      def load(type)
        require_relative("#{type}/#{type}")
      end

    end
  end
end
