module Divisions
  class Bindings < ::Emissions::Divisible

    def complete? = all_complete?(all)

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def embedded_blueprints = embeds.map(&:blueprint)

    def connects = all.reject(&:embed?)

    def embeds = filtered(:embeds) { all.select(&:embed?) }

    def turtles = filtered(:turtles) { all }

    def filtered(method, &block)
      (yield || []).map { |b| [b, under(b, method)] }.flatten.uniq(&:identifier)
    end

    def under(binding, method)
      if (b = binding.blueprint).has?(:bindings)
        b.bindings.send(method)
      else
        []
      end
    end

    def method_missing(m, *args, &block) =  named(m) || super
    def respond_to_missing?(m, *) = named(m) || super

  end
end
