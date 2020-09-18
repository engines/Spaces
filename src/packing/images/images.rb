require_relative '../../releases/divisible'

module Packing
  module Images
    class Images < ::Releases::Divisible

      def script_file_names
        all.map(&:script_file_names).flatten.uniq
      end

      def subdivision_for(struct)
        universe.packing.images.by(struct: struct, division: self)
      end

    end
  end
end
