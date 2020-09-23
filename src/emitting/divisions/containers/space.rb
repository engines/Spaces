module Provisioning
  module Containers
    class Space < Emissions::SubdivisionSpace

      class << self
        def default_model_class
          Container
        end
      end

    end
  end
end
