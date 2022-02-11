module Registry
  class Space < ::Emissions::Space

    class << self
      def default_model_class
        ConsumerEntry
      end

      def default_service_class
        ServiceEntry
      end
    end

    delegate(default_service_class: :klass)

    def ensure_entered(resolution)
      resolution.connections_down.each { |c| ensure_entered(c) }
      resolution.registered.map { |r| save(r) }
    end

    def service_by(identifiable, klass = default_service_class)
      klass.new(identifiable: identifiable)
    end

    def life_cycle_milestones_for(identifiable)
      life_cycle_paths_for(identifiable).map(&:basename).map(&:to_sym)
    end

    def life_cycle_paths_for(identifiable)
      path_for(identifiable).glob('milestones/*').reject(&:directory?)
    end

    protected

    def ensure_connected_entries_exist_for(resolution)
      resolution.connections_down.each { |c| ensure_entered(c) }
    end

  end
end
