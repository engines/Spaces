module Providers
  class Lua < ::Adapters::ModuleList

    def inline = struct.map { |s| "luarocks install #{s}" }

  end
end
