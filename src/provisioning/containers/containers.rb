require_relative '../../releases/divisible'

module Provisioning
  module Containers
    class Containers < ::Releases::Divisible

      def subdivision_for(struct)
        universe.provisioning.containers.by(struct: struct, division: self)
      end

    end
  end
end
