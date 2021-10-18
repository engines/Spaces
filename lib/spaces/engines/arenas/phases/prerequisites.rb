module Arenas
  module Prerequisites
    include ::Engines::Prerequisites

    def prerequisite_role_map
      @prerequisite_map ||= {
        packing: [:docker],
        provisioning: [:terraform],
        runtime: [:docker]
      }
    end

    def runtime_prerequisite; prerequisite_for(:runtime) ;end
    def packing_prerequisite; prerequisite_for(:packing) ;end
    def provisioning_prerequisite; prerequisite_for(:provisioning) ;end

    def runtime_qualifier; runtime_prerequisite.qualifier ;end
    def packing_qualifier; packing_prerequisite.qualifier ;end

  end
end
