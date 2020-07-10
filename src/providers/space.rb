require_relative '../spaces/subspace'

module Providers
  class Space < ::Spaces::Subspace

    class << self
      def default_model_class
        Provider
      end
    end

    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
