module Providers
  class Pear < ::Providers::Modules

    def inline
      struct.map { |s| "pear install #{s}" }
    end

  end
end
