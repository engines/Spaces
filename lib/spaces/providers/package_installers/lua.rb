require_relative 'installer'

module PackageInstallers
  class Lua < Installer

    def command = struct.map { |s| "luarocks install #{s}" }

  end
end
