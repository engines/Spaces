module Providers
  class Pecl < ::Providers::Modules

    def inline
      struct.map { |s| "pecl install #{s}" }
    end

  end
end
