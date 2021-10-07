#TODO: still required?

module Adapters
  class Packers < DivisionAdapter

    delegate packing_stanzas: :division

  end
end
