module Providers
  class Apache < ::Divisions::NoduleArray

    def inline
      struct.map { |s| "a2enmod #{s}" }
    end

  end
end
