require_relative 'installer'

module PackageInstallers
  class Pear < Installer

    def command = struct.map { |s| "pear install #{s}" }

  end
end
