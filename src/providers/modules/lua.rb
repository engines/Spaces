module Providers
  class Lua < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "luarocks install #{s}" }
    end

  end
end
