module Divisions
  class Volumes < ::Emissions::SubclassDivisible

    def all
      @all ||=
      if emission.has?(:containers)
        emission.containers.all.map do |c|
          struct&.map { |s| subdivision_for(s, c.type) }&.compact || []
        end.flatten
      else
        []
      end
    end

    def subdivision_for(struct, container_type)
      super(duplicate(struct).tap { |s| s.type = "#{container_type}/volume" })
    end

  end
end
