module Divisions
  class Bindings < ::Emissions::Divisible

    def complete?; all_complete?(all) ;end

    def embed(other)
      tap do
        self.struct = [struct, other.struct].flatten.uniq(&:descriptor)
      end
    end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def embedded_blueprints; embeds.map(&:blueprint) ;end

    def connects
      all.reject(&:embed?)
    end

    def embeds
      all.select(&:embed?).map { |e| [e, embeds_under(e)] }.flatten.uniq
    end

    def embeds_under(embed)
      if (b = embed.blueprint).has?(:bindings)
        b.bindings.embeds
      else
        []
      end
    end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
