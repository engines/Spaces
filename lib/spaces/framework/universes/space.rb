module Universes
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class; Universe ;end
    end

    def path; workspace ;end

    def universe
      # @universe ||= exist_then_by(universe_identifier) || default_model_class.new(identifiable: universe_identifier)
      @universe ||= default_model_class.new(identifiable: universe_identifier)
    end

    def universe_identifier; :universe ;end

    def initialize(identifier: :universe)
      super
    end

  end
end
