require_relative '../../releases/division'

module Provisioning
  module Providers
    class Providers < ::Releases::Division

      def subdivision_for(struct)
        universe.provisioning.providers.by(struct: struct, division: self)
      end

    end
  end
end
