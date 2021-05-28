module Providers
  class Lua < ::Providers::ModuleList

    def inline
      struct.map { |s| "luarocks install #{s}" }
    end

  end
end
