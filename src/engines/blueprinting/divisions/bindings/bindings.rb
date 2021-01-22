module Divisions
  class Bindings < ::Emissions::Divisible

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def connects; turtles.reject(&:embed?) ;end
    def embeds; turtles.select(&:embed?) ;end

    def turtles
      all.map { |b| [b, turtles_under(b)] }.flatten.uniq(&:identifier)
    end

    def turtles_under(binding)
      (b = binding.blueprint).has?(:bindings) ? b.bindings.turtles : []
    end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
