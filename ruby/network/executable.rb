require_relative '../engines/model'
require_relative '../executable/executable'

module Network
  class Executable < Engines::Model
    # The understanding of an executable locatable and accesible on a network

    relation_accessor :executable

  end
end
