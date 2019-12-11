require_relative '../framework/model'
require_relative '../executable/executable'

module Environment
  class Executable < ::Framework::Model
    # The understanding of an executable inside an environment

    relation_accessor :executable

  end
end
