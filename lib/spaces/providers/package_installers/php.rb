require_relative 'installer'

module PackageInstallers
  class Php < Installer

    def command = struct.map { |s| "phpenmod #{s}" }

  end
end
