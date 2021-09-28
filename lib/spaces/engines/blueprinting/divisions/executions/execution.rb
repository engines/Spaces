module Divisions
  class Execution < ::Divisions::Subdivision
    include PackDefining

    def identifier; type ;end

    def inflated; self ;end
    def deflated; self ;end

  end
end
