module Arenas
  module Resourcing

    def container_registry
      # ASSUMING THERE IS ONLY ONE PER ARENA
      # or, if there isn't, just grab the first one
      resources_by(:container_registry).first
    end

    def resources_by(type)
      resources.select { |r| r.type.to_sym == type.to_sym }
    end

    def resources
      @resources ||= resolutions_with_resources.map(&:resources).map(&:all).flatten
    end

    def resolutions_with_resources
      @resolutions_with_resources ||= bound_resolutions.select { |r| r.has?(:resources) }
    end

  end
end
