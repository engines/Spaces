require_relative 'thing'

module Spaces
  class Schema < Thing

    delegate(outline: :klass)

  end
end
