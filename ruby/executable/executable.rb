require_relative '../spaces/product'
require_relative 'tensor'
require_relative '../container/executable'
require_relative '../environment/environment'
require_relative '../network/executable'

module Executable
  class Executable < ::Spaces::Product

    # A software product as loaded into a piece of hardware

    relation_accessor :container,
      :environment,
      :network

  end
end
