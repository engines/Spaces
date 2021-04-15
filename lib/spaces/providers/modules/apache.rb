module Providers
  class Apache < ::Providers::Modules

    def inline
      struct.map { |s| "a2enmod #{s}" }
    end

  end
end
