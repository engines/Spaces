require_relative 'requires'
require_relative '../package'
require_relative 'package_installation'

class Software
  class Installation < Spaces::Script

    def body
      context.packages.map { |p| package_installation_class.new(p).content }
    end

    def header
      [
        super,
        %Q(
          mkdir /tmp/packages
          cd /tmp/packages
        )
      ]
    end

    def package_installation_class
      PackageInstallation
    end

  end
end
