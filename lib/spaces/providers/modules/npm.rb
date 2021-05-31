module Providers
  class Npm < ::Providers::ModuleList

    def inline
      struct.map { |s| "npm install #{s}" }
    end

  end
end
