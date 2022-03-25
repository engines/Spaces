require_relative 'space'

module Spaces
  class DelegatedSpace < Space

    def all
      interface.all
    end

  end
end
