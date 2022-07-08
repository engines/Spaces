module Locating
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class = ::Locating::Location
    end

    def ensure_located(publication)
      publication.bindings.descriptors.each do |d|
        save(default_model_class.new(d.struct)) unless exist?(d)
      end
    end

  end
end
