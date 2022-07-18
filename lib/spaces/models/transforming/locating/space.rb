module Locating
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class = ::Locating::Location
    end

    def ensure_located(model)
      unless exist?(model)
        save(default_model_class.new(model.struct))
      end
    end

  end
end
