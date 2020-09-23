module Provisioning
  module Containers
    class Containers < ::Emissions::Divisible

      def subdivision_for(struct)
        universe.provisioning.containers.by(struct: struct, division: self)
      end

    end
  end
end
