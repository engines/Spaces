require_relative '../engines/model'
require_relative '../executable/executable'

module Environment
  class Executable < Engines::Model
    # The understanding of an executable inside an environment

    relation_accessor :executable

  end
end
