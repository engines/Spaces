require_relative 'installer'

module PackageInstallers
  class Apache < Installer

    def command = struct.map { |s| "#{command_type} #{s}" }

  end
end
