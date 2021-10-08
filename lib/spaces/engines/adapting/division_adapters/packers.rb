#TODO: still required?

module Adapters
  class Packers < DivisionAdapter

    delegate packing_snippets: :division

  end
end
