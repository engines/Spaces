require_relative '../../emitting/divisible'

module Provisioning
  module Providers
    class Providers < ::Emitting::Divisible

      def subdivision_for(struct)
        universe.provisioning.providers.by(struct: struct, division: self)
      end

    end
  end
end
