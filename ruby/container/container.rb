require_relative '../spaces/product'

module Container
  class Container < ::Spaces::Product
    # A mechanism by which software can be made executable.

    relation_accessor :executable

  end
end
