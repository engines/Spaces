module Providers
  class Apache < ::Providers::ModuleList

    def inline      
      struct.map { |s| "a2enmod #{s}" }
    end

  end
end
