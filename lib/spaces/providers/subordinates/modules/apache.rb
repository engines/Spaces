module Providers
  class Apache < ::Adapters::ModuleList

    def inline
      struct.map { |s| "a2enmod #{s}" }
    end

  end
end
