module Domains
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class
        Domain
      end
    end

  end
end
