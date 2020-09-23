module Providers
  class Space < Emissions::SubdivisionSpace

    class << self
      def default_model_class
        Provider
      end
    end

  end
end
