require_relative '../framework/model'
require_relative 'container'
require_relative '../executable/executable'

module Container
  class Executable < ::Framework::Model
    # The understanding of an executable inside a container

    relation_accessor :executable,
      :container

  end
end
