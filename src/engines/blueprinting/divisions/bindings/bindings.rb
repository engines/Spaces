module Divisions
  class Bindings < ::Emissions::Divisible

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def connect_targets; turtle_targets.reject(&:embed?) ;end
    def embed_targets; turtle_targets.select(&:embed?) ;end

    def turtle_targets
      all.map { |b| [b, turtle_targets_under(b)] }.flatten.uniq(&:identifier)
    end

    def turtle_targets_under(binding)
      (b = binding.blueprint).has?(:bindings) ? b.bindings.turtle_targets : []
    end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
