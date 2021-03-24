module Providers
  class Npm < ::Providers::Modules

    def inline
      struct.map { |s| "npm install #{s}" }
    end

  end
end
