module Providers
  class Lua < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "luarocks install #{s}" }

  end
end
