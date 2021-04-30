module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    module Graphing

      def graphed(emission_type)
        if t = target_for(emission_type)
          empty.tap do |m|
            m.struct = struct
            m.struct.graph = t.struct unless hard_looping_on?(t)
          end
        end
      end

      def target_for(type); send(type) ;end

      def hard_looping_on?(target)
        target.identifier == context_identifier
      end

    end
  end
end
