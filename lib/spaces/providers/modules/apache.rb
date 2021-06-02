module Providers
  class Apache < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "a2enmod #{s}" }
    end

  end
end
