module Providers
  class Pear < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "pear install #{s}" }
    end

  end
end
