module Providers
  class Pecl < ::Providers::ModuleList

    def inline
      struct.map { |s| "pecl install #{s}" }
    end

  end
end
