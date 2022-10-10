module Divisions
  class Images < ::Divisions::Bindings

    def struct_merged_with(other) = super.uniq(&:runtimes)

  end
end
