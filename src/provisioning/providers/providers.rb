require_relative '../../releases/divisible'

module Provisioning
  module Providers
    class Providers < ::Releases::Divisible

      def subdivision_for(struct)
        universe.provisioning.providers.by(struct: struct, division: self)
      end

    end
  end
end
