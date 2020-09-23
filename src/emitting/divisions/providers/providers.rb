module Providers
  class Providers < ::Emissions::Divisible

    def subdivision_for(struct)
      universe.provisioning.providers.by(struct: struct, division: self)
    end

  end
end
