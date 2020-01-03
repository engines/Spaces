require_relative '../spaces/model'
require_relative 'container'
require_relative '../executable/executable'

module Container
  class Executable < ::Spaces::Model
    # The understanding of an executable inside a container

    relation_accessor :executable,
      :container

  end
end
