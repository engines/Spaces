require_relative '../framework/model'
require_relative '../executable/executable'

module Network
  class Executable < ::Framework::Model
    # The understanding of an executable locatable and accesible on a network

    relation_accessor :executable

  end
end
