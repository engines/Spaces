module Providers
  class Php < ::Providers::Modules

    def inline
      struct.map { |s| "phpenmod #{s}" }
    end

  end
end
