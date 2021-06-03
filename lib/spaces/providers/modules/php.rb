module Providers
  class Php < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "phpenmod #{s}" }
    end

  end
end
