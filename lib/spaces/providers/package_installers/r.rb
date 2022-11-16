require_relative 'installer'

module PackageInstallers
  class R < Installer

    def command = struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }

  end
end
