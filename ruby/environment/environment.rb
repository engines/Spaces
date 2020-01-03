require_relative '../spaces/model'
require_relative '../executable/executable'

module Environment
  class Environment < ::Spaces::Model
    # The understanding of an executable inside an environment

    relation_accessor :executable

  end
end
