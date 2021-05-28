module Providers
  class R < ::Providers::ModuleList

    def inline
      struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }
    end

  end
end
