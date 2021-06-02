module Providers
  class Npm < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "npm install #{s}" }
    end

  end
end
