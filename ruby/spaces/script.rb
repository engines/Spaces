require_relative 'product'

module Spaces
  class Script < Product

    relation_accessor :context
    attr_reader :content

    def initialize(context)
      self.context = context
    end

  end
end
