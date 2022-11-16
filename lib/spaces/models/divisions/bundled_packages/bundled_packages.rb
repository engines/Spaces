module Divisions
  class BundledPackages < ::Divisions::Divisible

    def subdivision_for(struct) = super.dynamic_type

    def path = Pathname(__dir__)

  end
end
