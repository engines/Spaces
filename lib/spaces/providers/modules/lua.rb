module Providers
  class Lua < ::Providers::Modules

    def inline
      struct.map { |s| "luarocks install #{s}" }
    end

  end
end
