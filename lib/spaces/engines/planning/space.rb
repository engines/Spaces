module Planning
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Plan
      end
    end

    alias_method :identifiers, :simple_identifiers

    def ensure_planned(publication)
      save(publication.planned) if publication.plannable?
    end

  end
end
