module Providers
  class Python < ::Providers::ModuleList

    def inline
      struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }
    end

  end
end
