module Providers
  class Php < ::Providers::ModuleList

    def inline
      struct.map { |s| "phpenmod #{s}" }
    end

  end
end
