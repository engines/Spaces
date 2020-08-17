require_relative '../../releases/subdivision_space'
require_relative 'container'

module Provisioning
  module Containers
    class Space < Releases::SubdivisionSpace

      class << self
        def default_model_class
          Container
        end
      end

      def load(type)
        require_relative("#{type}/#{type}")
      end

    end
  end
end
