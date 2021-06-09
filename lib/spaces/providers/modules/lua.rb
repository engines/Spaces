module Providers
  class Lua < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "luarocks install #{s}" }
    end

  end
end
