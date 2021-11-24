module Blueprinting
  module Arenas

    def indirect_arenas
      all_arenas - direct_arenas
    end

    def all_arenas
      arenas_all.select do |a|
        a.deep_bindings.map(&:target_identifier).include?(identifier) # NOW WHAT?
      end
    end

    def direct_arenas
      arenas_all.select { |a| a.bindings.map(&:target_identifier).include?(identifier) } # NOW WHAT?
    end

    def arenas_all; @arenas_all ||= arenas.all ;end

  end
end
