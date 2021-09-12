require_relative 'model'

module Spaces
  class UniverseSpace < Space

    class << self
      def default_model_class; Universe ;end
    end

    def universe
      @universe ||= exist_then_by(universe_identifier) || default_model_class.new(identifiable: universe_identifier)
    end

    def universe_identifier; :universe ;end

    def path; workspace.join("#{identifier}") ;end

    def initialize(identifier = :universe)
      super
    end

  end
end
