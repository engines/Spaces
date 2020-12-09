module Providers
  class Pecl < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "pecl install #{s}" }
    end

  end
end
