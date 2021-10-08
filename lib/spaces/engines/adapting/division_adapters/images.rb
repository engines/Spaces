module Adapters
  class Images < DivisionAdapter

    delegate all: :division

    def snippets
      all.map(&:provider_division_aspect).map(&:packing_snippet)
    end

  end
end
