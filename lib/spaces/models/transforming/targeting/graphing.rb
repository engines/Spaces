module Targeting
  module Graphing

    def graphed(emission_type)
      empty.tap do |m|
        m.struct = struct
        m.struct.graph = graph_for(emission_type)
      end
    end

    def graph_for(emission_type)
      if t = target_for(emission_type)
        t.struct unless hard_looping_on?(t)
      end
    end

    def target_for(type); send(type) ;end

    def hard_looping_on?(target)
      target.identifier == context_identifier
    end

    def circular_in?(identifiers)
      identifiers.include?(target_identifier)
    end

  end
end
