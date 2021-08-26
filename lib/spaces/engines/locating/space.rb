module Locating
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        ::Locating::Location
      end
    end

    alias_method :identifiers, :simple_identifiers

    def ensure_located(publication)
      publication.bindings.descriptors.each { |d| save(d) unless exist?(d)}
    end

  end
end
