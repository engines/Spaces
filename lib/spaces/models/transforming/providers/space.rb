module Providers
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class
        Provider
      end
    end

    def application_qualifiers
      default_model_class.application_qualifiers
    end

  end
end
