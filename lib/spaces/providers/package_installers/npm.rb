require_relative 'installer'

module PackageInstallers
  class Npm < Installer

    def command = struct.map { |s| "npm install #{s}" }

  end
end
