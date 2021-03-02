module Providers
  class Python < ::Providers::Modules

    def inline
      struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }
    end

  end
end
