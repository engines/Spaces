module Divisions
  class OtherPackages < ::Emissions::Divisible

    alias_method :divisible_embed!, :embed!

    include ::Packing::Division

    def embed!(other) = divisible_embed!(other)

    def packing_stanza_for(key) = (all.map(&:packing_stanza) if key == :adds)

    def keys = [:adds]

  end
end
