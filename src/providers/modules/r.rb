module Providers
  class R < ::Providers::Modules

    def inline
      struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }
    end

  end
end
