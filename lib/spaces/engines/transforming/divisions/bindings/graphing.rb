module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    module Graphing

      def graphed(qualifier)
        empty.tap do |m|
          m.struct = struct
          m.struct.graph = send(qualifier).struct
        end
      end

    end
  end
end
