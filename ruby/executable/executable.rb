require_relative '../engines/product'
require_relative 'tensor'
require_relative '../container/executable'
require_relative '../environment/executable'
require_relative '../network/executable'

module Executable
  class Executable < Engines::Product

    # A software product as loaded into a piece of hardware

    relation_accessor :container,
      :environment,
      :network

  end
end
