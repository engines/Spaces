module Providers
  class Npm < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "npm install #{s}" }
    end

  end
end
