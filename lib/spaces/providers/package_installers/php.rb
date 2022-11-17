require_relative 'installer'

module PackageInstallers
  class Php < Installer

    def command = struct.map { |s| "#{command_type} #{s}" }

  end
end
