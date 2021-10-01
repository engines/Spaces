module Divisions
  class SystemPackages < ::Divisions::Division
    include ::Packing::Division

    def inflated; self ;end
    def deflated; self ;end

  end
end
