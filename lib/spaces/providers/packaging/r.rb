require_relative 'installer'

module Packaging
  class R < Installer

    def command = struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }

  end
end
