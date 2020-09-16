require_relative '../../releases/division'

module Provisioning
  module Containers
    class Containers < ::Releases::Division

      def subdivision_for(struct)
        universe.provisioning.containers.by(struct: struct, division: self)
      end

    end
  end
end
