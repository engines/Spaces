module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    module Graphing

      def graphed(emission_type)
        if e = emission_for(emission_type)
          empty.tap do |m|
            m.struct = struct
            m.struct.graph = e.struct
          end
        end
      end

      def emission_for(type); send(type) ;end

    end
  end
end
