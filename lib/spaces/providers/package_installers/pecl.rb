require_relative 'installer'

module PackageInstallers
  class Pecl < Installer

    def command = struct.map { |s| "pecl install #{s}" }

  end
end
