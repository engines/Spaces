module Locating
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        ::Spaces::Descriptor
      end
    end

    alias_method :identifiers, :simple_identifiers

    def ensure_located(publication)
      if publication.plannable?
        publication.bindings.descriptors.each { |d| save(d) unless exist?(d)}
      end
    end

  end
end
