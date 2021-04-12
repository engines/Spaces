module Emissions
  module Topology

    def graph(**args)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.bindings = bindings.graphed(**args).struct
        end
      end
    end

  end
end
