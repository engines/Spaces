module Providers
  class Pear < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "pear install #{s}" }
    end

  end
end
