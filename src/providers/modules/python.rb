module Providers
  class Python < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }
    end

  end
end
