module Providers
  class Pecl < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "pecl install #{s}" }
    end

  end
end
