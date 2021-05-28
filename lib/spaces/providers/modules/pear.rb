module Providers
  class Pear < ::Providers::ModuleList

    def inline
      struct.map { |s| "pear install #{s}" }
    end

  end
end
