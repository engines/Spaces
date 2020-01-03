require_relative '../spaces/model'
require_relative '../executable/executable'

module Network
  class Executable < ::Spaces::Model
    # The understanding of an executable locatable and accesible on a network

    relation_accessor :executable

  end
end
