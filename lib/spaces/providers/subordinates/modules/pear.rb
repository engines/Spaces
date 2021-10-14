module Providers
  class Pear < ::Adapters::ModuleList

    def inline
      struct.map { |s| "pear install #{s}" }
    end

  end
end
