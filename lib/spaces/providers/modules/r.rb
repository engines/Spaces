module Providers
  class R < ::ProviderAspects::ModuleList

    def inline
      struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }
    end

  end
end
