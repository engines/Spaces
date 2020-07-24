require_relative '../../releases/division'

module Packing
  module Builders
    class Builders < ::Releases::Division

      def subdivision_for(struct)
        universe.packing.builders.by(struct: struct, division: self)
      end

    end
  end
end
