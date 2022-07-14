module Providers
  class R < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }

  end
end
