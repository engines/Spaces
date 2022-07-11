module Arenas
  module Resourcing

    # ASSUMING THERE IS ONLY ONE PER ARENA
    # or, if there isn't, just grab the first one
    def container_registry = resources_by(:container_registry).first

    def resources_by(type) =
      resources.select { |r| r.type.to_sym == type.to_sym }

    def resources
      @resources ||= resolutions_with_resources.map(&:resources).map(&:all).flatten
    end

    def resolutions_with_resources
      @resolutions_with_resources ||= bound_resolutions.select { |r| r.has?(:resources) }
    end

  end
end
