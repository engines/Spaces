module Providers
  class Php < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "phpenmod #{s}" }
    end

  end
end
