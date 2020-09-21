require_relative '../../emitting/emissions/division_space'

module Provisioning
  module Providers
    class Space < Emitting::SubdivisionSpace

      class << self
        def default_model_class
          Provider
        end
      end

      def load(type)
        require_relative("#{type}/#{type}")
      end

    end
  end
end
