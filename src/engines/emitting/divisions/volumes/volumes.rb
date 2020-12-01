module Divisions
  class Volumes < ::Emissions::SubclassDivisible

    def embed(other)
      tap do
        self.struct = [struct, other.struct].flatten.uniq(&:source)
      end
    end

    def all
      @all ||=
      if emission.has?(:containers)
        emission.containers.all.map do |c|
          struct&.map { |s| container_specific_subdivision_for(s, c.type) }&.compact || []
        end.flatten
      else
        struct&.map { |s| generic_subdivision_for(s) } || []
      end
    end

    def container_specific_subdivision_for(struct, container_type)
      subdivision_for(duplicate(struct).tap { |s| s.type = "#{container_type}/volume" })
    end

  end
end
