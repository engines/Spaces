require_relative 'installer'

module PackageInstallers
  class Apache < Installer

    def command = struct.map { |s| "a2enmod #{s}" }

  end
end
