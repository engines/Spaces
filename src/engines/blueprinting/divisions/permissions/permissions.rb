module Divisions
  class Permissions < ::Emissions::Divisible

    alias_method :divisible_embed!, :embed!

    include ::Packing::Division

    def embed!(other); divisible_embed!(other) ;end

    def packing_stanza_for(key)
      all.map(&:packing_stanza) if key == :late
    end

    def keys; [:late] ;end

  end
end
