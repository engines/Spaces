require_relative '../../releases/division'

module Packing
  module Images
    class Images < ::Releases::Division

      def subdivision_for(struct)
        universe.packing.images.by(struct: struct, division: self)
      end

    end
  end
end
