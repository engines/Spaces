module Providers
  class R < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "R -e 'install.packages(\"#{s}\")'" }
    end

  end
end
