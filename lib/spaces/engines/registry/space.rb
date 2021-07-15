module Registry
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Entry
      end
    end

    def ensure_entered(resolution)
      resolution.registered.map { |r| save(r) }
    end

  end
end
