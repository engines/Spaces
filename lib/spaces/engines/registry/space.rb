module Registry
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Entry
      end
    end

    def ensure_entered(resolution)
      resolution.connections_down.each { |c| ensure_entered(c) }
      resolution.registered.map { |r| save(r) }
    end

    protected

    def ensure_connected_entries_exist_for(resolution)
      resolution.connections_down.each { |c| ensure_entered(c) }
    end

  end
end
